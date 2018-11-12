module Ui.Color exposing (darken)

import Color exposing (Color)
import Css


fromCss : Css.Color -> Color
fromCss { red, green, blue, alpha } =
    Color.fromRgba
        { red = toFloat red / 256
        , green = toFloat green / 256
        , blue = toFloat blue / 256
        , alpha = alpha
        }


toCss : Color -> Css.Color
toCss color =
    let
        { hue, saturation, lightness, alpha } =
            Color.toHsla color
    in
    Css.hsla hue saturation lightness alpha


darken : Float -> Css.Color -> Css.Color
darken factor =
    lighten -factor


lighten : Float -> Css.Color -> Css.Color
lighten factor cssColor =
    let
        hsla =
            cssColor |> fromCss |> Color.toHsla
    in
    Color.fromHsla { hsla | lightness = clamp 0 1 (hsla.lightness + factor) }
        |> toCss
