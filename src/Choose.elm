----------------------------------------------------------------------
--
-- Choose.elm
-- Data processing for NoRedInk's two-hour programming challenge.
-- Copyright (c) 2017 Bill St. Clair <billstclair@gmail.com>
-- Some rights reserved.
-- Distributed under the MIT License
-- See LICENSE.txt
--
----------------------------------------------------------------------

module Choose exposing ( Sequence, SequenceMaker
                       , chooseEqualStrands
                       , chooseEqualStandards
                       , chooseEqualQuestions
                        )

import Data exposing ( Question, questions, emptyQuestion )
import Dict exposing ( Dict )
import Maybe exposing ( withDefault )

type QuestionList
    = LeafList (List Question, List Question)
    | NodeList (List QuestionList, List QuestionList)

type alias Sequence =
    List Question

type alias SequenceMaker =
    Int -> Sequence

log = Debug.log

segregate : List (Question -> Int) -> QuestionList
segregate getters =
    gettersLoop getters questions

gettersLoop : List (Question -> Int) -> List Question -> QuestionList
gettersLoop getters questions =
    case getters of
        [] ->
            LeafList ([], [])   --can't happen
        [getter] ->
            let qss = questionsLoop getter questions Dict.empty
                qls = List.map (\qs -> LeafList (qs, qs)) qss
            in
                NodeList (qls, qls)
        getter :: tail ->
            let qss = questionsLoop getter questions Dict.empty
                qls = List.map (gettersLoop tail) qss
            in
                NodeList (qls, qls)

questionsLoop : (Question -> Int) -> List Question -> Dict Int (List Question) -> List (List Question)
questionsLoop getter questions dict =
    case questions of
        [] ->
            List.map Tuple.second <| Dict.toList dict
        q :: tail ->
            let id =  getter q
                qs = q :: (withDefault [] <| Dict.get id dict)
            in
                questionsLoop getter tail <| Dict.insert id qs dict

-- It would be good to randomize here.
-- We'd need to pass a Seed around, or maybe just a list of
-- random values from 0.0 to 1.0, at this level.
chooser : Int -> List (Question -> Int) -> List Question
chooser count getters =
    let qlist = segregate getters
    in
        chooserLoop count qlist []

chooserLoop : Int -> QuestionList -> List Question -> List Question
chooserLoop count ql res =
    if count <= 0 then
        res
    else
        let (q, ql2) = pickOne ql
        in
            chooserLoop (count-1) ql2 <| q :: res

pickOne : QuestionList -> (Question, QuestionList)                            
pickOne ql =
    case ql of
        LeafList (qs, allqs) ->
            case qs of
                [] ->
                    if allqs == [] then
                        (emptyQuestion, ql) --Can't happen unless no questions
                    else
                        pickOne <| LeafList (allqs, allqs)
                q :: qtail ->
                    (q , LeafList (qtail, allqs))
        NodeList (ns, allns) ->
            case ns of
                [] ->
                    if allns == [] then
                        (emptyQuestion, ql)
                    else
                        pickOne <| NodeList (allns, allns)
                n :: ntail ->
                    let (q, n2) = pickOne n
                    in
                        (q, NodeList (List.append ntail [n2], allns))

chooseEqualStrands : SequenceMaker
chooseEqualStrands count =
    chooser count [.strandId]

chooseEqualStandards : SequenceMaker
chooseEqualStandards count =
    chooser count [.strandId, .standardId]

-- The way I did it, this one isn't any different
chooseEqualQuestions : SequenceMaker
chooseEqualQuestions count =
    chooseEqualStandards count

