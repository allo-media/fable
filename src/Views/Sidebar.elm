module Views.Sidebar exposing (item, itemActive, list, title, view)

import Css exposing (..)
import Data.Bookmark exposing (Bookmark(..))
import Data.Chapter exposing (Chapter, ChapterId(..))
import Data.Msg exposing (Msg(..))
import Data.Story exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Route.Route as Route exposing (Route(..))
import Views.Theme exposing (Element)


defaultItem : Style
defaultItem =
    Css.batch
        [ display block
        , padding (px 5)
        , cursor pointer
        , color (rgb 255 255 255)
        , textDecoration none
        , hover
            [ backgroundColor (rgb 99 167 245)
            , borderRadius (px 3)
            ]
        ]


title : Element msg
title =
    styled span
        [ color (rgb 255 255 255)
        , padding2 (px 10) (px 5)
        , marginBottom (px 10)
        , borderBottom2 (px 1) dotted
        , display block
        ]


item : Element msg
item =
    styled a
        [ defaultItem ]


itemActive : Element msg
itemActive =
    styled span
        [ defaultItem
        , backgroundColor (rgba 99 167 245 0.8)
        , borderRadius (px 3)
        ]


list : Element msg
list =
    styled ul
        [ listStyle none
        , padding (px 10)
        , Css.width (px 200)
        , marginTop (px 30)
        ]


story : Bookmark -> Chapter msg -> Story msg -> Html (Msg msg)
story bookmark (( chapterTitle, _ ) as chapter_) (( storyTitle, _ ) as story_) =
    case bookmark of
        StoryBookmark chapterId storyId ->
            if storyTitle == storyIdToString storyId then
                itemActive [] [ text storyTitle ]

            else
                item [ Route.href (Route.Story (ChapterId chapterTitle) (StoryId storyTitle)) ] [ text storyTitle ]

        UiBookmark chapterId storyId uiId ->
            if storyTitle == storyIdToString storyId then
                itemActive [] [ text storyTitle ]

            else
                item [ Route.href (Route.Story (ChapterId chapterTitle) (StoryId storyTitle)) ] [ text storyTitle ]

        _ ->
            item [ Route.href (Route.Story (ChapterId chapterTitle) (StoryId storyTitle)) ] [ text storyTitle ]


chapter : Bookmark -> Chapter msg -> Html (Msg msg)
chapter bookmark (( chapterTitle, stories ) as chapter_) =
    li []
        [ title [] [ text chapterTitle ]
        , List.map (story bookmark chapter_) stories
            |> ul [ css [ listStyle none, padding zero ] ]
        ]


view : Bookmark -> List (Chapter msg) -> Html (Msg msg)
view bookmark chapters =
    div
        [ css
            [ backgroundColor (rgb 47 51 56)
            , Css.width (pct 100)
            , Css.height (pct 100)
            , displayFlex
            , justifyContent center
            ]
        ]
        [ List.map (chapter bookmark) chapters
            |> list []
        ]
