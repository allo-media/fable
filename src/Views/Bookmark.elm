module Views.Bookmark exposing (none, view)

import Css exposing (..)
import Css.Global exposing (descendants, typeSelector)
import Data.Bookmark exposing (Bookmark(..))
import Data.Chapter as Chapter exposing (Chapter, ChapterId(..))
import Data.Msg exposing (Msg(..))
import Data.Story as Story exposing (StoryId(..))
import Data.Ui as Ui exposing (UiId(..), find)
import Html.Styled as Html exposing (..)
import Html.Styled.Attributes exposing (..)
import Views.Icon as Icon
import Views.Menu.Primary as MenuPrimary
import Views.Menu.Secondary as MenuSecondary
import Views.Sidebar as Sidebar
import Views.Theme exposing (Element, theme, updateAlphaColor)
import Views.Ui as VUi


none : Html msg
none =
    div
        [ css
            [ Css.property "display" "grid"
            , Css.property "grid-template-row" "auto auto"
            , Css.property "justify-content" "center"
            , Css.property "align-content" "center"
            , fontSize (rem 2)
            , color (rgba 0 0 0 0.5)
            , backgroundColor (rgba 255 255 255 0.99)
            , fontFamilies [ "Montserrat", .value serif ]
            , descendants
                [ typeSelector "svg"
                    [ fill (updateAlphaColor theme.backgroundMainColor 0.9)
                    , Css.width (Css.rem 2)
                    , Css.property "align-self" "center"
                    ]
                ]
            ]
        ]
        [ text "Hey, I'm lost. I think that somethings get wrong."
        ]


layout : Element msg
layout =
    styled div
        [ Css.property "display" "grid"
        , Css.property "grid-template-columns" "13fr 21fr"
        , Css.height (vh 100)
        ]


view : Bookmark -> List (Chapter msg) -> List (Html (Msg msg))
view bookmark chapters =
    case bookmark of
        UiBookmark chapterId storyId uiId ->
            let
                chapter =
                    Chapter.find chapterId chapters
                        |> Maybe.withDefault { id = ChapterId "error", stories = [] }

                story =
                    Story.find storyId chapter.stories
                        |> Maybe.withDefault { id = StoryId "error", uis = [] }

                ui =
                    Ui.find uiId story.uis
                        |> Maybe.withDefault { id = UiId "errror", view = div [] [] }
            in
            [ Sidebar.layout []
                [ div []
                    [ Sidebar.logo [] [ Icon.fable ]
                    , MenuPrimary.view (MenuPrimary.select chapterId storyId) chapters
                    ]
                , MenuSecondary.view chapterId storyId (Just uiId) story.uis
                ]
            , VUi.view ui
            ]

        _ ->
            [ Sidebar.layout []
                [ div [ css [ Css.property "grid-column" "1/3" ] ]
                    [ Sidebar.logo [] [ Icon.fable ]
                    , MenuPrimary.view MenuPrimary.nothing chapters
                    ]
                ]
            , none
            ]
