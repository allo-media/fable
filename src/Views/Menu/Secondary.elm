module Views.Menu.Secondary exposing (view)

import Css exposing (..)
import Data.Bookmark exposing (Bookmark(..))
import Data.Chapter as Chapter exposing (Chapter, ChapterId(..))
import Data.Msg exposing (Msg(..))
import Data.Story as Story exposing (Story, StoryId(..))
import Data.Ui as Ui exposing (Ui, UiId(..))
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, href)
import Route.Route as Route
import Views.Theme exposing (Element)


defaultLink : Style
defaultLink =
    Css.batch
        [ textDecoration none
        , Css.width (pct 100)
        , Css.height (pct 100)
        , Css.property "display" "grid"
        , Css.property "align-items" "center"
        , color (rgb 0 0 0)
        , marginBottom (rem 1)
        , fontFamilies [ "Montserrat", .value serif ]
        ]


item : Element msg
item =
    styled li
        [ borderBottom3 (px 1) solid (rgba 0 0 0 0.05)
        , Css.property "display" "grid"
        , Css.property "grid-template-rows" "auto 1fr"
        , padding2 (px 10) (px 15)

        -- , hover [ backgroundColor (rgba 213 160 33 0.05) ]
        -- , active [ backgroundColor (rgba 213 160 33 0.1) ]
        , hover [ backgroundColor (rgba 213 160 33 0.05) ]
        , active [ backgroundColor (rgba 213 160 33 0.1) ]
        ]


link : Element msg
link =
    styled a
        [ defaultLink
        ]


list : Element msg
list =
    styled ul
        [ -- backgroundColor (rgb 255 255 255)
          listStyle none
        , padding zero
        , margin zero
        , borderRight3 (px 2) solid (rgba 0 0 0 0.05)
        , Css.height (vh 100)
        ]


name : Element msg
name =
    styled span
        [ fontSize (rem 1.125)
        , fontWeight bold
        , textTransform capitalize
        ]


ui : ChapterId -> StoryId -> Maybe UiId -> Ui msg -> Html (Msg msg)
ui chapterId storyId uiId ui_ =
    let
        active =
            Maybe.map ((==) ui_.id) uiId
                |> Maybe.withDefault False
    in
    item [] [ link [ Route.href (Route.Ui chapterId storyId ui_.id) ] [ name [] [ text (Ui.idToString ui_.id) ] ] ]


view : ChapterId -> StoryId -> Maybe UiId -> List (Ui msg) -> Html (Msg msg)
view chapterId storyId uiId uis =
    List.map (ui chapterId storyId uiId) uis
        |> list []
