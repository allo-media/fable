module Views.Submenu exposing (item, link, view)

import Css exposing (..)
import Data.Bookmark exposing (Bookmark(..))
import Data.Chapter exposing (Chapter, ChapterId(..))
import Data.Msg exposing (Msg(..))
import Data.Story exposing (Story, StoryId(..))
import Data.Ui as Ui exposing (Ui, UiId(..))
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css)
import Route.Route as Route
import Views.Theme exposing (Element)


default : Style
default =
    batch
        [ textDecoration none
        , backgroundColor (rgb 255 255 255)
        , Css.width (px 80)
        , Css.height (px 30)
        , Css.property "display" "grid"
        , Css.property "align-items" "center"
        , textAlign center
        , color (rgb 0 0 0)
        , padding (px 10)
        , borderBottom3 (px 3) solid (rgb 255 255 255)
        , hover
            [ borderBottom3 (px 3) solid (rgba 99 167 245 0.8)
            ]
        ]


link : Element msg
link =
    styled a
        [ default ]


linkActive : Element msg
linkActive =
    styled span
        [ default
        , borderBottom3 (px 3) solid (rgba 99 167 245 1)
        ]


item : Element msg
item =
    styled li [ minWidth (px 80) ]


layout : Element msg
layout =
    styled ul
        [ backgroundColor (rgb 248 248 248)
        , borderBottom3 (px 1) solid (rgb 181 181 181)
        , margin zero
        , Css.height (px 80)
        , Css.property "display" "grid"
        , Css.property "grid-auto-flow" "column"
        , Css.property "justify-content" "flex-start"
        , Css.property "align-items" "flex-end"
        , listStyle none
        , padding zero
        , Css.width (pct 100)
        ]


ui : Bookmark -> Chapter msg -> Story msg -> Ui msg -> Html (Msg msg)
ui bookmark chapter story ui_ =
    item []
        [ case bookmark of
            UiBookmark chapterId storyId uiId ->
                if uiId == ui_.id then
                    linkActive [] [ text (Ui.idToString ui_.id) ]

                else
                    link [ Route.href (Route.Ui chapterId storyId ui_.id) ] [ text (Ui.idToString ui_.id) ]

            _ ->
                link [ Route.href (Route.Ui (Tuple.first chapter) (Tuple.first story) ui_.id) ] [ text (Ui.idToString ui_.id) ]
        ]


view : Bookmark -> Chapter msg -> Story msg -> Html (Msg msg)
view bookmark chapter story =
    List.map (ui bookmark chapter story) (Tuple.second story)
        |> layout []
