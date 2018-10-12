module Main exposing (main)

import Css exposing (..)
import Fable as Fable exposing (Book)
import Html.Styled exposing (Html, button, input, text)
import Html.Styled.Attributes exposing (css)
import Html.Styled.Events exposing (..)


type Msg
    = OnInput String
    | Yo


inputView : Html Msg
inputView =
    input [ css [ padding2 (px 10) (px 5) ], onInput OnInput ]
        []


button_ : Html Msg
button_ =
    button [ onClick Yo ] [ text "Yo à nous le magot" ]


main : Book Msg
main =
    let
        chapters =
            [ Fable.chapter "Chapter 1"
                [ Fable.story "Story 1"
                    [ Fable.ui "test 1" inputView
                    , Fable.ui "test 2" button_
                    ]
                , Fable.story "Story 32 %"
                    [ Fable.ui "test 3" inputView
                    , Fable.ui "test 4" button_
                    ]
                ]
            ]
    in
    Fable.app chapters
