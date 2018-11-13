module Views.Menu.Secondary exposing (view)

import Css exposing (..)
import Css.Animations as CA
import Data.Bookmark exposing (Bookmark(..))
import Data.Chapter as Chapter exposing (Chapter)
import Data.Msg exposing (Msg(..))
import Data.Story as Story exposing (Story)
import Data.Ui as Ui exposing (Ui)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, href)
import Route.Route as Route
import Views.Theme exposing (Element, theme, updateAlphaColor)


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
        , padding2 (px 15) (px 10)
        ]


defaultItem : Style
defaultItem =
    let
        { red, green, blue, alpha } =
            theme.backgroundMainColor
    in
    Css.batch
        [ borderBottom3 (px 1) solid (rgba 0 0 0 0.05)
        , Css.property "display" "grid"
        , Css.property "grid-template-rows" "auto 1fr"
        , hover
            [ Css.animationName
                (CA.keyframes
                    [ ( 0, [ CA.backgroundColor (rgba 255 255 255 0) ] )
                    , ( 100, [ CA.backgroundColor (updateAlphaColor theme.backgroundMainColor 0.1) ] )
                    ]
                )
            , Css.animationDuration (Css.ms 500)
            , Css.animationIterationCount (Css.num 1)
            , Css.backgroundColor (updateAlphaColor theme.backgroundMainColor 0.1)
            ]
        , active [ Css.backgroundColor (updateAlphaColor theme.backgroundMainColor 0.2) ]
        ]


itemActive : Style
itemActive =
    let
        { red, green, blue, alpha } =
            theme.backgroundMainColor
    in
    Css.batch
        [ defaultItem
        , Css.backgroundColor (updateAlphaColor theme.backgroundMainColor 0.2)
        ]


link : Element msg
link =
    styled a
        [ defaultLink
        ]


list : Element msg
list =
    styled ul
        [ listStyle none
        , padding zero
        , margin zero
        , borderRight3 (px 2) solid (rgba 0 0 0 0.05)
        , Css.height (vh 100)
        , backgroundColor (rgba 255 255 255 1)
        , position relative
        ]


layout : List (Html (Msg msg)) -> Html (Msg msg)
layout content =
    div []
        [ list [] content
        ]


name : Element msg
name =
    styled span
        [ fontSize (rem 1.125)
        , fontWeight bold
        , textTransform capitalize
        ]


ui : Chapter.Id -> Story.Id -> Maybe Ui.Id -> Ui msg -> Html (Msg msg)
ui chapterId storyId uiId ui_ =
    let
        active =
            Maybe.map ((==) ui_.id) uiId
                |> Maybe.withDefault False
    in
    li
        [ css
            [ if active then
                itemActive

              else
                defaultItem
            ]
        ]
        [ link [ Route.href (Route.Ui chapterId storyId ui_.id) ] [ name [] [ text (Ui.idToString ui_.id) ] ] ]


view : Chapter.Id -> Story.Id -> Maybe Ui.Id -> List (Ui msg) -> Html (Msg msg)
view chapterId storyId uiId uis =
    List.map (ui chapterId storyId uiId) uis
        |> layout
