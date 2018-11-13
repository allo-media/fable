module Ui.Theme exposing (Element, defaultCss, formStyle, identify, placeHolder, theme)

import Css exposing (..)
import Css.Global exposing (body, everything, global, html, img)
import Css.Transitions exposing (easeInOut, transition)
import Html.Styled exposing (Attribute, Html)


type alias Theme =
    { primaryColor : Color
    , dangerColor : Color
    , primaryBgColor : Color
    , warningColor : Color
    , primaryBgImageGradient : Style
    , fonts : List String
    }


type alias Element msg =
    List (Attribute msg) -> List (Html msg) -> Html msg


identify_ : String -> Style
identify_ string =
    "Ui.Theme." ++ string |> identify


defaultCss : Html msg
defaultCss =
    global
        [ html
            [ identify "defaultCss"
            , width (pct 100)
            , height (pct 100)
            , fontSize (px 14)
            ]
        , body
            [ identify "defaultCss"
            , margin2 auto auto
            , width (pct 100)
            , height (pct 100)
            , fontFamilies theme.fonts
            , backgroundColor theme.primaryBgColor
            , color (hex "354052")
            , fontFamilies theme.fonts
            , fontWeight (int 500)
            , lineHeight (pct 140)
            , fontSize (Css.rem 1)
            , letterSpacing (px 0.3)
            ]
        , everything
            [ boxSizing borderBox
            ]
        ]


identify : String -> Style
identify styleName =
    property "-style-name" styleName


theme : Theme
theme =
    { primaryColor = rgba 130 97 230 1
    , primaryBgColor = rgba 236 241 247 1
    , dangerColor = rgba 248 82 88 1
    , warningColor = rgba 247 151 28 1
    , primaryBgImageGradient =
        backgroundImage
            (linearGradient2 (deg 131)
                (stop2 (hex "746BDE") (pct 23))
                (stop2 (hex "381CE2") (pct 100))
                []
            )
    , fonts = [ "Montserrat", .value sansSerif ]
    }



-- Forms


formStyle : Style
formStyle =
    Css.batch
        [ identify_ "formStyle"
        , borderRadius (px 3)
        , backgroundColor (hex "fff")
        , border3 (px 2) solid (rgba 208 208 208 0.5)
        , padding2 (px 10) (px 13)
        , marginBottom (px 10)
        , outline none
        , color (hex "354052")
        , fontWeight (int 500)
        , display block
        , transition
            [ Css.Transitions.border3 100 0 easeInOut
            ]
        , hover
            [ borderColor (rgba 208 208 208 0.8)
            ]
        , focus
            [ borderColor theme.primaryColor
            ]
        , disabled
            [ backgroundColor (hex "e9edf1")
            , borderColor (hex "dfe3e9")
            , hover
                [ borderColor (hex "dfe3e9")
                ]
            ]
        , placeHolder
            [ color (hex "9caecc")
            , fontStyle italic
            ]
        ]



-- Helpers


placeHolder : List Style -> Style
placeHolder styles =
    batch
        [ pseudoElement "-webkit-input-placeholder" styles
        , pseudoElement "-moz-placeholder" styles
        , pseudoClass "-ms-input-placeholder" styles
        , pseudoClass "-moz-placeholder" styles
        ]
