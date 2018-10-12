module Main exposing (main)

import Book as Book exposing (Book)
import Css exposing (..)
import Html.Styled exposing (Html, button, input)
import Html.Styled.Attributes exposing (css)
import Html.Styled.Events exposing (..)


type Msg
    = OnInput String
    | Yo


inputView : Html Msg
inputView =
    input [ css [ padding2 (px 10) (px 5) ], onInput OnInput |> Debug.log "input" ]
        []


button_ : Html Msg
button_ =
    button [ onClick Yo ] []


main : Book Msg
main =
    let
        chapters =
            [ Book.chapter "Chapter 1"
                [ Book.story "Story 1"
                    [ Book.ui "test 1" inputView
                    , Book.ui "test 2" button_
                    ]
                , Book.story "Story 32 %"
                    [ Book.ui "test 3" inputView
                    , Book.ui "test 4" button_
                    ]
                ]
            ]
    in
    Book.app chapters
