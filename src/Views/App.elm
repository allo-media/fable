module Views.App exposing (layout)

import Css exposing (..)
import Css.Global exposing (..)
import Data.Bookmark exposing (Bookmark(..))
import Data.Chapter exposing (Chapter)
import Html exposing (Html)
import Html.Styled as HS exposing (div, text, toUnstyled)
import Html.Styled.Attributes exposing (css)


layout : HS.Html msg -> List (Html msg)
layout content =
    [ global
        [ html
            [ margin zero
            , padding zero
            ]
        , body
            [ margin zero
            , padding zero
            , fontFamilies [ "Montserrat", .value serif ]
            , fontSize (px 16)
            , boxSizing borderBox
            ]
        ]
        |> toUnstyled
    , div
        [ css
            [ Css.property "display" "grid"
            , Css.property "grid-template-columns" "auto 1fr"
            , Css.height (vh 100)
            ]
        ]
        [ content ]
        |> toUnstyled
    ]
