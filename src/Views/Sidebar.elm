module Views.Sidebar exposing (item, itemActive, list, title, view)

import Css exposing (..)
import Data.Bookmark exposing (Bookmark(..))
import Data.Chapter as Chapter exposing (Chapter, ChapterId(..))
import Data.Msg exposing (Msg(..))
import Data.Story as Story exposing (..)
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


chapter : Bookmark -> Chapter msg -> Html (Msg msg)
chapter bookmark ({ id, stories } as chapter_) =
    li []
        [ title [] [ text (Chapter.idToString id) ]
        , List.map (story bookmark chapter_) stories
            |> ul [ css [ listStyle none, padding zero ] ]
        ]


story : Bookmark -> Chapter msg -> Story msg -> Html (Msg msg)
story bookmark ({ id, stories } as chapter_) story_ =
    case bookmark of
        StoryBookmark chapterId_ storyId_ ->
            if story_.id == storyId_ then
                itemActive [] [ text (Story.idToString storyId_) ]

            else
                item [ Route.href (Route.Story chapter_.id story_.id) ] [ text (Story.idToString story_.id) ]

        UiBookmark chapterId_ storyId_ uiId_ ->
            if storyId_ == story_.id then
                itemActive [] [ text (Story.idToString storyId_) ]

            else
                item [ Route.href (Route.Story chapter_.id story_.id) ] [ text (Story.idToString story_.id) ]

        _ ->
            item [ Route.href (Route.Story chapter_.id story_.id) ] [ text (Story.idToString story_.id) ]


view : Bookmark -> List (Chapter msg) -> Html (Msg msg)
view bookmark chapters =
    div
        [ css
            [ backgroundColor (rgb 47 51 56)
            , Css.width (pct 100)
            , Css.height (pct 100)
            , displayFlex
            , justifyContent center
            , fontFamilies [ "Montserrat", .value serif ]
            , fontSize (px 16)
            ]
        ]
        [ List.map (chapter bookmark) chapters
            |> list []
        ]
