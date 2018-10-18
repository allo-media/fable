module Views.Bookmark exposing (none, view)

import Css exposing (..)
import Data.Bookmark exposing (Bookmark(..))
import Data.Chapter as Chapter exposing (Chapter)
import Data.Msg exposing (Msg(..))
import Data.Story as Story exposing (Story)
import Data.Ui as Ui exposing (find)
import Html.Styled as Html exposing (..)
import Html.Styled.Attributes exposing (..)
import Views.Sidebar as Sidebar
import Views.Submenu as Submenu
import Views.Theme exposing (Element)


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
        , Css.property "grid-template-columns" "auto 1fr"
        , Css.height (vh 100)
        ]


view : Bookmark -> List (Chapter msg) -> Html (Msg msg)
view bookmark chapters =
    case bookmark of
        ChapterBookmark chapterId ->
            {- -}
            div [] []

        StoryBookmark chapterId storyId ->
            case Chapter.find chapterId chapters of
                Just chapter ->
                    case Story.find storyId chapter.stories of
                        Just story ->
                            layout []
                                [ Sidebar.view bookmark chapters
                                , Submenu.view bookmark chapter story
                                ]

                        Nothing ->
                            layout []
                                [ Sidebar.view bookmark chapters
                                , none
                                ]

                Nothing ->
                    layout []
                        [ Sidebar.view bookmark chapters
                        , none
                        ]

        UiBookmark chapterId storyId uiId ->
            case Chapter.find chapterId chapters of
                Just chapter ->
                    case Story.find storyId chapter.stories of
                        Just story ->
                            case Ui.find uiId story.uis of
                                Just ui ->
                                    layout []
                                        [ Sidebar.view bookmark chapters
                                        , div []
                                            [ Submenu.view bookmark chapter story
                                            , div [ css [ padding (px 20) ] ]
                                                [ ui.view
                                                    |> Html.map ExternalMsg
                                                ]
                                            ]
                                        ]

                                Nothing ->
                                    layout []
                                        [ Sidebar.view bookmark chapters
                                        , none
                                        ]

                        Nothing ->
                            layout []
                                [ Sidebar.view bookmark chapters
                                , none
                                ]

                Nothing ->
                    layout []
                        [ Sidebar.view bookmark chapters
                        , none
                        ]

        None ->
            layout [] [ Sidebar.view bookmark chapters ]
