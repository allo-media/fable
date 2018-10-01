module Main exposing (main)

import Book exposing (Model, Msg, book)
import Data.Chapter exposing (Chapter)
import Html.Styled exposing (button, input)
import Html.Styled.Events exposing (..)


type MsgEx
    = OnInput String
    | Yo


chapterList : List (Chapter MsgEx)
chapterList =
    let
        _ =
            Debug.log "yo" Yo
    in
    [ ( "Chapter éeze1"
      , [ ( "Story 1 ", [ { name = "test", view = input [ onInput OnInput ] [] } ] )
        , ( "Story 32 %", [ { name = "test", view = button [ onClick Yo ] [] } ] )
        ]
      )
    ]


main : Program () (Model MsgEx) (Msg MsgEx)
main =
    book chapterList
