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

import Data exposing ( Question, questions )
import Dict exposing ( Dict )
import Maybe exposing ( withDefault )

type alias Sequence =
    List Question

type alias SequenceMaker =
    Int -> Sequence

segregate : (Question -> comparable) -> Dict comparable (List Question)
segregate typer =
    segregateLoop typer questions Dict.empty

segregateLoop : (Question -> comparable) -> List Question -> Dict comparable (List Question) -> Dict comparable (List Question)
segregateLoop typer questions res =
    case questions of
        [] ->
            res
        q :: tail ->
            let typ = typer q
                qs = q :: (withDefault [] <| Dict.get typ res)
            in
                segregateLoop typer tail <| Dict.insert typ qs res

-- It would be good to randomize here.
-- The way Elm works, we'd have to pre-generate a suitably
-- long list of random numbers, and pass them in.
chooser : Int -> (Question -> comparable) -> List Question
chooser count typer =
    let dict = segregate typer
        lists = Dict.toList dict
    in
        chooserLoop count dict [] lists

chooserLoop : Int -> Dict comparable (List Question)-> List Question -> List (comparable, List Question) -> List Question
chooserLoop count dict res lists =
    if count <= 0 then
        res
    else
        case lists of
            [] -> res           -- won't happen unless data is empty
            (typ, qs) :: rest ->
                case qs of
                    [] -> res --can't happen
                    q :: rqs ->
                        case rqs of
                            [] ->
                                case Dict.get typ dict of
                                    Nothing ->
                                        res --can't happen
                                    Just rqs2 ->
                                        chooserLoop (count-1) dict
                                            (q :: res)
                                            <| List.append rest [(typ, rqs2)]
                            _ ->
                                chooserLoop (count-1) dict
                                    (q :: res)
                                    <| List.append rest [(typ, rqs)]
                            

equalStrandsType : Question -> Int
equalStrandsType q =
    q.strandId

chooseEqualStrands : SequenceMaker
chooseEqualStrands count =
    chooser count equalStrandsType

equalStandardsType : Question -> (Int, Int)
equalStandardsType q =
    (q.strandId, q.standardId)

chooseEqualStandards : SequenceMaker
chooseEqualStandards count =
    chooser count equalStandardsType

-- The way I did it, this one isn't any different
chooseEqualQuestions : SequenceMaker
chooseEqualQuestions count =
    chooseEqualStandards count

