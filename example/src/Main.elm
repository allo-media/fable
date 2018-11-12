module Main exposing (main)

import Css exposing (..)
import Fable as Fable exposing (Book)
import Html.Styled exposing (Html, button, div, h1, input, text)
import Html.Styled.Attributes exposing (css)
import Html.Styled.Events exposing (..)


type Msg
    = NoOp


main : Book Msg
main =
    let
        chapters =
            [ Fable.chapter "Chapter 1"
                [ Fable.story "Story"
                    [ Fable.ui "ui-1" (div [] [ h1 [] [ text "test" ] ])
                    ]
                ]
            ]
    in
    Fable.app chapters
