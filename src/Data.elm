----------------------------------------------------------------------
--
-- Data.elm
-- Data for NoRedInk's two-hour programming challenge.
-- Copyright (c) 2017 Bill St. Clair <billstclair@gmail.com>
-- Some rights reserved.
-- Distributed under the MIT License
-- See LICENSE.txt
--
----------------------------------------------------------------------

module Data exposing ( Question, Usage, emptyQuestion, questions, usage )

-- If there's time, parse the CSV files. For now, just enter the data.

-- Defined in instructions/questions.csv
type alias Question =
    { strandId : Int
    , strandName : String
    , standardId : Int
    , standardName : String
    , questionId : Int
    , difficulty : Float
    }

emptyQuestion : Question
emptyQuestion =
    { strandId = 0
    , strandName = ""
    , standardId = 0
    , standardName = ""
    , questionId = 0
    , difficulty = 0.0
    }

-- Emacs keyboard macros rock!
questions : List Question
questions =
    let makeQuestion : (Int, String, Int, String, Int, Float ) -> Question
        makeQuestion = (\( sid, sn, stid, stn, qid, d ) ->
                           Question sid sn stid stn qid d
                       )
    in
        List.map makeQuestion
            [ ( 1, "Nouns", 1, "Common Nouns", 1, 0.7 )
            , ( 1, "Nouns", 1, "Common Nouns", 2, 0.6 )
            , ( 1, "Nouns", 2, "Abstract Nouns", 3, 0.8 )
            , ( 1, "Nouns", 3, "Proper Nouns", 4, 0.2 )
            , ( 1, "Nouns", 3, "Proper Nouns", 5, 0.5 )
            , ( 1, "Nouns", 3, "Proper Nouns", 6, 0.4 )
            , ( 2, "Verbs", 4, "Action Verbs", 7, 0.9 )
            , ( 2, "Verbs", 4, "Action Verbs", 8, 0.1 )
            , ( 2, "Verbs", 5, "Transitive Verbs", 9, 0.3 )
            , ( 2, "Verbs", 5, "Transitive Verbs", 10, 0.6 )
            , ( 2, "Verbs", 5, "Transitive Verbs", 11, 0.4 )
            , ( 2, "Verbs", 6, "Reflexive Verbs", 12, 0.2 )
            ]

-- Defined in instructions/usage.csv
type alias Usage =
    { studentId : Int
    , questionId : Int
    , assignedHoursAgo : Float  --data looks like integers,  but it won't be.
    , answeredHoursAgo : Maybe Float  --data looks like integers,  but it won't be.
    }

usage : List Usage
usage =
    let makeUsage : ( Int, Int, Float, Maybe Float ) -> Usage
        makeUsage = (\ (sid, qid, aho, anho) ->
                         Usage sid qid aho anho
                    )
    in
        List.map makeUsage
            [ ( 1, 2, 1.0, Just 1.0 )
            , ( 2, 4, 1.0, Nothing )
            , ( 3, 1, 1.0, Just 1.0 )
            , ( 2, 5, 1.0, Nothing )
            , ( 1, 4, 2.0, Just 1.0 )
            , ( 3, 2, 2.0, Just 2.0 )
            , ( 1, 6, 2.0, Nothing )
            , ( 2, 5, 2.0, Just 2.0 )
            , ( 1, 4, 3.0, Just 1.0 )
            , ( 3, 3, 3.0, Just 2.0 )
            , ( 1, 5, 3.0, Nothing  )
            , ( 2, 1, 3.0, Just 3.0 )
            , ( 3, 2, 4.0, Just 1.0 )
            , ( 1, 4, 4.0, Just 3.0 )
            , ( 2, 2, 4.0, Just 4.0 )
            , ( 2, 3, 4.0, Nothing )
            , ( 3, 2, 5.0, Just 4.0 )
            ]
