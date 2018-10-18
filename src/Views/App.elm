module Views.App exposing (view)

import Css exposing (..)
import Css.Global exposing (..)
import Data.Msg exposing (Msg)
import Html exposing (Html)
import Html.Styled as HS exposing (div, text, toUnstyled)
import Html.Styled.Attributes exposing (css)


view : HS.Html (Msg msg) -> List (Html (Msg msg))
view content =
    List.map toUnstyled
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
        , content
        ]
