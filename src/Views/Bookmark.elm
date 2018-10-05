module Views.Bookmark exposing (none, view)

import Css exposing (..)
import Data.Bookmark exposing (Bookmark(..))
import Data.Chapter as Chapter exposing (Chapter, chapterIdToString)
import Data.Msg exposing (Msg(..))
import Data.Story as Story exposing (Story, storyIdToString)
import Data.Ui as Ui exposing (find, uiIdToString)
import Html.Styled as Html exposing (..)
import Html.Styled.Attributes exposing (..)
import Views.Sidebar as Sidebar
import Views.Submenu as Submenu
import Views.Theme exposing (Element)


none : Element msg
none =
    styled div
        [ Css.property "display" "grid"
        , Css.property "justify-content" "center"
        , Css.property "align-content" "center"
        , fontSize (rem 2)
        , color (rgba 0 0 0 0.5)
        ]


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
            div [] []

        StoryBookmark chapterId storyId ->
            case Chapter.find (chapterIdToString chapterId) chapters of
                Just chapter ->
                    case Story.find (storyIdToString storyId) (Tuple.second chapter) of
                        Just story ->
                            layout []
                                [ Sidebar.view bookmark chapters
                                , Submenu.view bookmark chapter story
                                ]

                        Nothing ->
                            layout []
                                [ Sidebar.view bookmark chapters
                                , none [] [ text "none" ]
                                ]

                Nothing ->
                    layout []
                        [ Sidebar.view bookmark chapters
                        , none [] [ text "none" ]
                        ]

        UiBookmark chapterId storyId uiId ->
            case Chapter.find (chapterIdToString chapterId) chapters of
                Just chapter ->
                    case Story.find (storyIdToString storyId) (Tuple.second chapter) of
                        Just story ->
                            case Ui.find (uiIdToString uiId) (Tuple.second story) of
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
                                        , none [] [ text "none" ]
                                        ]

                        Nothing ->
                            layout []
                                [ Sidebar.view bookmark chapters
                                , none [] [ text "none" ]
                                ]

                Nothing ->
                    layout []
                        [ Sidebar.view bookmark chapters
                        , none [] [ text "none" ]
                        ]

        None ->
            layout [] [ Sidebar.view bookmark chapters ]
