module Views.Submenu exposing (item, link, linkActive, view)

import Css exposing (..)
import Html.Styled exposing (..)
import Theme exposing (Element)


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
    styled li
        [ minWidth (px 80)
        ]


view : Element msg
view =
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
