module Views.Ui exposing (view)

import Css exposing (..)
import Data.Msg exposing (Msg(..))
import Data.Ui as Ui exposing (Ui, UiId(..))
import Html.Styled as Html exposing (..)
import Html.Styled.Attributes exposing (..)
import Views.Theme exposing (Element)


layout : Element msg
layout =
    styled div
        [ Css.property "display" "grid"
        , justifyContent center
        , alignItems center
        , position relative
        , backgroundColor (hex "f0ebe05e")
        ]


title : UiId -> Html msg
title uiId =
    h1
        [ css
            [ fontSize (rem 3.125)
            , textTransform capitalize
            , fontFamilies [ "Montserrat", .value serif ]
            ]
        ]
        [ text (Ui.idToString uiId) ]


ui : Html msg -> Html (Msg msg)
ui view_ =
    div
        [ css
            [ backgroundColor (hex "FFF")
            , padding (px 20)
            , borderRadius (px 5)
            , boxShadow4 zero (px 5) (px 8) (rgba 0 0 0 0.1)
            ]
        ]
        [ view_
            |> Html.map ExternalMsg
        ]


view : Ui msg -> Html (Msg msg)
view ui_ =
    layout []
        [ div
            [ css
                [ position absolute
                , top (Css.pct 10)
                , bottom (Css.pct 30)
                , left (Css.pct 10)
                , right (Css.pct 10)
                , Css.property "display" "grid"
                , Css.property "grid-template-rows" "auto 1fr"
                ]
            ]
            [ title ui_.id
            , ui ui_.view
            ]
        ]
