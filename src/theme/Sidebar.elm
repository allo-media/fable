module Theme.Sidebar exposing (item, itemActive, list, title, view)

import Css exposing (..)
import Html.Styled exposing (..)
import Theme exposing (Element)


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


view : Element msg
view =
    styled div
        [ backgroundColor (rgb 47 51 56)
        , Css.width (pct 100)
        , Css.height (pct 100)
        , displayFlex
        , justifyContent center
        ]


list : Element msg
list =
    styled ul
        [ listStyle none
        , padding (px 10)
        , Css.width (px 200)
        , marginTop (px 30)
        ]
