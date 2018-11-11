module Views.Sidebar exposing (layout, logo)

import Css exposing (..)
import Css.Global exposing (descendants, typeSelector)
import Data.Bookmark exposing (Bookmark(..))
import Data.Chapter as Chapter exposing (Chapter)
import Data.Msg exposing (Msg(..))
import Data.Story as Story exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Route.Route as Route exposing (Route(..))
import Views.Icon as Icon
import Views.Menu.Primary as MenuPrimary
import Views.Menu.Secondary as MenuSecondary
import Views.Theme exposing (Element)


layout : Element msg
layout =
    styled div
        [ Css.property "display" "grid"
        , Css.property "grid-template-columns" "5fr 8fr"
        ]


logo : Element msg
logo =
    styled div
        [ backgroundColor (rgba 0 0 0 0.05)
        , Css.height (vh 20)
        , borderBottom3 (Css.px 1) solid (rgba 255 255 255 0.2)
        , displayFlex
        , justifyContent center
        , alignItems center
        ]
