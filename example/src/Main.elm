module Main exposing (main)

import Book exposing (Model, book)
import Css exposing (..)
import Data.Chapter exposing (Chapter, ChapterId(..))
import Data.Msg exposing (Msg(..))
import Data.Story exposing (StoryId(..))
import Data.Ui exposing (Ui, UiId(..))
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
    [ ( ChapterId "Chapter éeze1"
      , [ ( StoryId "Story 1 ", [ { id = UiId "test", view = inputView } ] )
        , ( StoryId "Story 32 %", [ { id = UiId "test", view = button [ onClick Yo ] [] } ] )
        ]
      )
    ]


main : Program () (Model MsgEx) (Msg MsgEx)
main =
    book chapterList
