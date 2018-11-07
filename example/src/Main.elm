module Main exposing (main)

import Css exposing (..)
import Fable as Fable exposing (Book)
import Html.Styled exposing (Html, button, input, text)
import Html.Styled.Attributes exposing (css)
import Html.Styled.Events exposing (..)


type Msg
    = OnInput String
    | Blur


inputView : Html Msg
inputView =
    input [ css [ padding2 (px 10) (px 5) ], onInput OnInput ]
        []


button_ : Html Msg
button_ =
    button [ onClick Blur ] [ text "Send" ]


main : Book Msg
main =
    let
        chapters =
            [ Fable.chapter "Chapter 1"
                [ Fable.story "Story 1"
                    [ Fable.ui "test 1" inputView
                    , Fable.ui "test 2" button_
                    , Fable.ui "test 3" inputView
                    , Fable.ui "test 4" button_
                    , Fable.ui "test 5" inputView
                    , Fable.ui "test 6" button_
                    , Fable.ui "test 7" inputView
                    , Fable.ui "test 8" button_
                    , Fable.ui "test 9" inputView
                    , Fable.ui "test 10" button_
                    ]
                , Fable.story "Story 32 %"
                    [ Fable.ui "test 3" inputView
                    , Fable.ui "test 4" button_
                    ]
                ]
            ]
    in
    Fable.app chapters
