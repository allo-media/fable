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
        , Css.width (pct 100)
        , Css.height (pct 100)
        , Css.property "display" "grid"
        , Css.property "align-items" "center"
        , textAlign center
        , color (rgb 0 0 0)
        , padding (px 10)
        ]


link : Element msg
link =
    styled a
        [ default ]


linkActive : Element msg
linkActive =
    styled span
        [ default ]


item : Element msg
item =
    styled li
        [ minHeight (px 135)
        , borderBottom3 (px 1) solid (rgba 0 0 0 0.05)
        , Css.property "display" "grid"
        , hover
            [ Css.property "box-shadow" "0 10px 40px 0 rgba(0, 0, 0, 0.1), 0 3px 4px 0 rgb(125, 4, 46)"
            ]
        ]


layout2 : Element msg
layout2 =
    styled ul
        [ backgroundColor (rgb 255 255 255)
        , listStyle none
        , padding zero
        , margin zero
        , border3 (px 2) solid (rgba 0 0 0 0.05)
        , Css.height (vh 100)
        , overflow auto
        ]


layout : Element msg
layout =
    styled ul
        [ backgroundColor (rgb 248 248 248)
        , borderBottom3 (px 1) solid (rgb 181 181 181)
        , margin zero
        , Css.height (px 80)
        , Css.property "display" "grid"
        , Css.property "grid-auto-flow" "column"
        , Css.property "align-items" "flex-end"
        , listStyle none
        , padding zero
        , Css.width (pct 100)
        , justifyContent flexStart
        , fontFamilies [ "Montserrat", .value serif ]
        ]


ui : Bookmark -> Chapter msg -> Story msg -> Ui msg -> Html (Msg msg)
ui bookmark chapter story ui_ =
    item []
        [ case bookmark of
            UiBookmark chapterId storyId uiId ->
                if uiId == ui_.id then
                    linkActive [] [ text (Ui.idToString ui_.id) ]

                else
                    link [ Route.href (Route.Ui chapterId story.id ui_.id) ] [ text (Ui.idToString ui_.id) ]

            _ ->
                link [ Route.href (Route.Ui chapter.id story.id ui_.id) ] [ text (Ui.idToString ui_.id) ]
        ]


view : Bookmark -> Chapter msg -> Story msg -> Html (Msg msg)
view bookmark chapter story =
    List.map (ui bookmark chapter story) story.uis
        |> layout2 []
