module Views.Bookmark exposing (none, view)

import Css exposing (..)
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
import Views.Theme exposing (Element)
import Views.Ui as VUi


none : Html msg
none =
    div
        [ css
            [ Css.property "display" "grid"
            , Css.property "justify-content" "center"
            , Css.property "align-content" "center"
            , fontSize (rem 2)
            , color (rgba 0 0 0 0.5)
            ]
        ]
        [ text "None" ]


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
                [ div [ css [ backgroundColor (hex "343E3D") ] ]
                    [ Sidebar.logo [] [ Icon.fable ]
                    , MenuPrimary.view (Just chapterId) (Just storyId) chapters
                    ]
                , MenuSecondary.view chapterId storyId (Just uiId) story.uis
                ]
            , VUi.view ui
            ]

        _ ->
            [ Sidebar.layout []
                [ div [ css [ backgroundColor (hex "343E3D") ] ]
                    [ Sidebar.logo [] [ Icon.fable ]
                    , MenuPrimary.view Nothing Nothing chapters
                    ]
                ]
            ]



-- [ Sidebar.view bookmark chapters
-- , none
-- ]
