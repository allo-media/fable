module Main exposing (main)

import Book exposing (Model, book)
import Css exposing (..)
import Data.Chapter exposing (Chapter)
import Data.Msg exposing (Msg(..))
import Html.Styled exposing (Html, button, input)
import Html.Styled.Attributes exposing (css)
import Html.Styled.Events exposing (..)


type MsgEx
    = OnInput String
    | Yo


inputView : Html MsgEx
inputView =
    input [ css [ padding2 (px 10) (px 5) ], onInput OnInput |> Debug.log "input" ]
        []


chapterList : List (Chapter MsgEx)
chapterList =
    [ ( "Chapter éeze1"
      , [ ( "Story 1 ", [ { name = "test", view = inputView } ] )
        , ( "Story 32 %", [ { name = "test", view = button [ onClick Yo ] [] } ] )
        ]
      )
    ]


main : Program () (Model MsgEx) (Msg MsgEx)
main =
    book chapterList
