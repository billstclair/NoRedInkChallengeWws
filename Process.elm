----------------------------------------------------------------------
--
-- Process.elm
-- Data processing for NoRedInk's two-hour programming challenge.
-- Copyright (c) 2017 Bill St. Clair <billstclair@gmail.com>
-- Some rights reserved.
-- Distributed under the MIT License
-- See LICENSE.txt
--
----------------------------------------------------------------------

module Process exposing ( Sequence, SequenceMaker
                        , equalStrands, equalStandards, equalQuestions
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

haveEqualStrands : Question -> Question -> Bool
haveEqualStrands q1 q2
    q1.strandId == q2.strandId

chooser : Int -> (Question -> comparable) -> List Question
chooser count typer =
    chooserLoop count [] <| segregate typer

chooserLoop : Int -> List Question -> List (comparable, List Question) -> Dict comparable (List Question) -> List Question
chooserLoop count res dict =
    

chooseEqualStrands : SequenceMaker
chooseEqualStrands count =
    chooser count haveEqualStrands

chooseEqualStandards : SequenceMaker
chooseEqualStandards count =
    questions

chooseEqualQuestions : SequenceMaker
chooseEqualQuestions count =
    questions

