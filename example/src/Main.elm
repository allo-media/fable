module Main exposing (main)

import Book exposing (Model, Msg, book)
import Data.Chapter exposing (Chapter)
import Html.Styled exposing (button)
import Html.Styled.Events exposing (..)


type MsgEx
    = Yo


chapterList : List (Chapter MsgEx)
chapterList =
    [ ( "Chapter éeze1"
      , [ ( "Story 1 ", [ { name = "test", view = button [ onClick Yo ] [] } ] )
        , ( "Story 32 %", [ { name = "test", view = button [ onClick Yo ] [] } ] )
        ]
      )
    ]


main : Program () (Model MsgEx) (Msg MsgEx)
main =
    book chapterList
