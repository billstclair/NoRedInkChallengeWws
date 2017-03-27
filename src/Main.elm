----------------------------------------------------------------------
--
-- Main.elm
-- A solution for NoRedInk's two-hour programming challenge.
-- Copyright (c) 2017 Bill St. Clair <billstclair@gmail.com>
-- Some rights reserved.
-- Distributed under the MIT License
-- See LICENSE.txt
--
-- The challenge instructions and data are in the `instructions`
-- directory.
--
----------------------------------------------------------------------

module Main exposing (..)

import Stylesheet exposing ( stylesheet )
import Data exposing ( Question )
import Choose exposing ( chooseEqualStrands
                        , chooseEqualStandards
                        , chooseEqualQuestions
                        )

import Html exposing ( Html, Attribute
                     , div, span, p, text, a, h1, h2, h3
                     , table, tr, td
                     , input, button
                     )
import Html.Attributes exposing ( style, class, value, size, href
                                , type_, name, checked
                                )
import Html.Events exposing ( on, onClick, onInput )

log = Debug.log

main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = (\x -> Sub.none)
        }

type alias Model =
    { text : String
    }

initialModel : Model
initialModel =
    { text = "Hello, Elm!"
    }

init : ( Model, Cmd Msg )
init =
    ( initialModel
    , Cmd.none
    )

type Msg
    = UpdateText String

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateText string ->
            ( { model
                  | text = string
              }
            , Cmd.none
            )

style_ : List (Attribute msg) -> List (Html msg) -> Html msg
style_ = Html.node "style"

view : Model -> Html Msg
view model =
    div []
        [ style_ [ type_ "text/css" ]
              [ text stylesheet ]
        , h1 [] [ text "NoRedInk Programming Challenge" ]
        , p [ class "centered" ]
            [ text "I got Process.elm computing the lists of questions, but I didn't get to querying for the count and printing the answers. That would have been a benefit of a command line app, instead of a full Elm app."
              text
                  <| "Process.chooseEqualStandards 10 -> " ++
                      (List.map .questionId <| chooseEqualStandards 10)
            ]
        ]

    
