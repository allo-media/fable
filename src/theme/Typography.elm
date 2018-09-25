module Theme.Typography exposing (link)

import Css exposing (..)
import Html.Styled exposing (..)
import Theme exposing (Element)


link : Element msg
link =
    styled a
        []
