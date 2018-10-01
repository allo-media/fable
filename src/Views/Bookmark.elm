module Views.Bookmark exposing (view)

import Css exposing (..)
import Data.Bookmark exposing (Bookmark)
import Data.Chapter exposing (Chapter)
import Html.Styled exposing (..)


view : Bookmark -> List (Chapter msg) -> Html msg
view bookmark msgChapter =
    div [] [ text " test " ]
