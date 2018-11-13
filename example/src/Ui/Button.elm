module Ui.Button exposing (danger, default, multiple, multipleCenter, multipleRight, primary, primaryFullWidth, secondary, warning)

import Css as Css exposing (..)
import Css.Transitions exposing (easeInOut, transition)
import Html.Styled exposing (button, div, styled)
import Ui.Color exposing (darken)
import Ui.Theme as Theme exposing (Element, identify, theme)


identify_ : String -> Style
identify_ string =
    "UI.Button." ++ string |> identify


styleDefault : Style
styleDefault =
    Css.batch
        [ identify_ "styleDefault"
        , textAlign center
        , color (hex "FFF")
        , border zero
        , padding2 (px 12) (px 18)
        , fontWeight (int 700)
        , borderRadius (px 3)
        , cursor pointer
        , outline none
        , transition
            [ Css.Transitions.background3 100 0 easeInOut
            ]
        ]


default : Element msg
default =
    styled button
        [ styleDefault
        , identify_ "default"
        , background (rgba 242 244 247 1) 0.1
        , color (rgba 242 244 247 1)
        ]


background : Color -> Float -> Style
background color ratio =
    Css.batch
        [ backgroundImage <|
            linearGradient
                (stop <| color)
                (stop <| darken ratio color)
                []
        , hover
            [ backgroundImage <|
                linearGradient
                    (stop <| darken (ratio / 2) color)
                    (stop <| darken (ratio * 1.1) color)
                    []
            ]
        , active
            [ backgroundImage <|
                linearGradient
                    (stop <| darken (ratio / 2) color)
                    (stop <| darken (ratio * 1.5) color)
                    []
            ]
        ]



-- Colors


danger : Element msg
danger =
    styled button
        [ styleDefault
        , identify_ "danger"
        , background theme.dangerColor 0.1
        ]


primary : Element msg
primary =
    styled button
        [ styleDefault
        , identify_ "primary"
        , background theme.primaryColor 0.1
        ]


secondary : Element msg
secondary =
    styled button
        [ identify_ "secondary" ]


warning : Element msg
warning =
    styled button
        [ styleDefault
        , identify_ "warning"
        , background theme.warningColor 0.05
        ]


primaryFullWidth : Element msg
primaryFullWidth =
    styled primary
        [ identify_ "primaryFullWidth"
        , width (pct 100)
        ]



-- Multiple


multipleStyle : Style
multipleStyle =
    Css.batch
        [ identify_ "multipleStyle"
        , property "display" "grid"
        , property "grid-auto-flow" "column"
        , property "grid-column-gap" "5px"
        ]


multiple : Element msg
multiple =
    styled div
        [ identify_ "multiple"
        , multipleStyle
        , justifyContent left
        ]


multipleCenter : Element msg
multipleCenter =
    styled div
        [ identify_ "multipleCenter"
        , multipleStyle
        , justifyContent center
        ]


multipleRight : Element msg
multipleRight =
    styled div
        [ identify_ "multipleRight"
        , multipleStyle
        , justifyContent right
        ]
