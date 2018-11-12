module Views.Theme exposing (Element, theme, updateAlphaColor)

import Css exposing (..)
import Html.Styled exposing (Attribute, Html)


type alias Element msg =
    List (Attribute msg) -> List (Html msg) -> Html msg


type alias Theme =
    { backgroundMainColor : Color
    }


theme : Theme
theme =
    { backgroundMainColor = hex "#05519A" }


updateAlphaColor : Color -> Float -> Color
updateAlphaColor color float =
    let
        { red, green, blue, alpha } =
            color
    in
    rgba red green blue float
