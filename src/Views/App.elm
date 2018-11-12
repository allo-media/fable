module Views.App exposing (view)

import Css exposing (..)
import Css.Global exposing (..)
import Data.Msg exposing (Msg)
import Html exposing (Html)
import Html.Styled as HS exposing (div, text, toUnstyled)
import Html.Styled.Attributes exposing (css)
import Views.Theme exposing (theme)


view : List (HS.Html (Msg msg)) -> List (Html (Msg msg))
view content =
    List.map toUnstyled
        [ global
            [ html [ margin zero, padding zero ]
            , body [ margin zero, padding zero, backgroundColor theme.backgroundMainColor ]
            , everything
                [ boxSizing borderBox
                , before [ boxSizing borderBox ]
                , after [ boxSizing borderBox ]
                ]
            ]
        , div
            [ css
                [ Css.property "display" "grid"
                , Css.property "grid-template-columns" "13fr 21fr"
                , Css.height (vh 100)
                ]
            ]
            content
        ]
