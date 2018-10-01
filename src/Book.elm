module Book exposing (Model, Msg(..), book)

import Browser exposing (Document, UrlRequest)
import Browser.Navigation exposing (Key, load, pushUrl)
import Css exposing (..)
import Css.Global exposing (body, global, html)
import Data.Bookmark as Bookmark exposing (Bookmark(..))
import Data.Chapter as Chapter exposing (Chapter, ChapterId(..), chapterIdToString, find)
import Data.Story as Story exposing (Story, StoryId(..), find, storyIdToString)
import Data.Ui as Ui exposing (Ui, UiId(..), find, uiIdToString)
import Html as H
import Html.Styled as HA exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (onClick)
import Route.Route as Route exposing (Route, href)
import Theme.Sidebar as Sidebar
import Theme.Submenu as Submenu
import Url exposing (Url)


type alias Model msg =
    { navKey : Key
    , bookmark : Bookmark
    , chapters : List (Chapter msg)
    }


type Msg msg
    = ExternalMsg msg
    | InternalMsg Internal


type Internal
    = UrlChanged Url
    | UrlRequested Browser.UrlRequest
    | NoOp


init : List (Chapter msg) -> () -> Url -> Key -> ( Model msg, Cmd (Msg msg) )
init chapters _ url key =
    setRoute (Route.fromUrl url)
        { navKey = key
        , bookmark = None
        , chapters = chapters
        }


setRoute : Maybe Route -> Model msg -> ( Model msg, Cmd (Msg msg) )
setRoute route model =
    case route of
        Nothing ->
            ( model, Cmd.none )

        Just (Route.Chapter chapterId) ->
            ( { model | bookmark = ChapterBookmark chapterId }, Cmd.none )

        Just (Route.Story chapterId storyId) ->
            ( { model | bookmark = StoryBookmark chapterId storyId }, Cmd.none )

        Just (Route.Ui chapterId storyId uiId) ->
            ( { model | bookmark = UiBookmark chapterId storyId uiId }, Cmd.none )

        Just Route.Home ->
            ( model, Cmd.none )


update : Msg msg -> Model msg -> ( Model msg, Cmd (Msg msg) )
update msg model =
    case msg of
        ExternalMsg externalMsg ->
            let
                _ =
                    Debug.log "msg" externalMsg
            in
            ( model, Cmd.none )

        InternalMsg internalMsg ->
            case internalMsg of
                UrlChanged url ->
                    setRoute (Route.fromUrl url) model

                UrlRequested urlRequest ->
                    case urlRequest of
                        Browser.Internal url ->
                            ( model, pushUrl model.navKey (Url.toString url) )

                        Browser.External url ->
                            ( model, load url )

                NoOp ->
                    ( model, Cmd.none )


view : Model msg -> Document (Msg msg)
view ({ bookmark } as model) =
    { title = Bookmark.title bookmark, body = bodyView model }


sidebarStoryView : Bookmark -> Chapter msg -> Story msg -> Html (Msg msg)
sidebarStoryView bookmark (( chapterTitle, _ ) as chapter) (( storyTitle, _ ) as story) =
    case bookmark of
        StoryBookmark chapterId storyId ->
            if storyTitle == storyIdToString storyId then
                Sidebar.itemActive [] [ text storyTitle ]

            else
                Sidebar.item [ Route.href (Route.Story (ChapterId chapterTitle) (StoryId storyTitle)) ] [ text storyTitle ]

        UiBookmark chapterId storyId uiId ->
            if storyTitle == storyIdToString storyId then
                Sidebar.itemActive [] [ text storyTitle ]

            else
                Sidebar.item [ Route.href (Route.Story (ChapterId chapterTitle) (StoryId storyTitle)) ] [ text storyTitle ]

        _ ->
            Sidebar.item [ Route.href (Route.Story (ChapterId chapterTitle) (StoryId storyTitle)) ] [ text storyTitle ]


sidebarChapterView : Bookmark -> Chapter msg -> Html (Msg msg)
sidebarChapterView bookmark (( title, stories ) as chapter) =
    li []
        [ Sidebar.title [] [ text title ]
        , List.map (sidebarStoryView bookmark chapter) stories
            |> ul [ css [ listStyle none, padding zero ] ]
        ]


sidebarView : Bookmark -> List (Chapter msg) -> Html (Msg msg)
sidebarView bookmark chapters =
    Sidebar.view []
        [ List.map (sidebarChapterView bookmark) chapters
            |> Sidebar.list []
        ]


submenuView : Bookmark -> Chapter msg -> Story msg -> Html (Msg msg)
submenuView bookmark chapter story =
    List.map (submenuUiView bookmark chapter story) (Tuple.second story)
        |> Submenu.view []


submenuUiView : Bookmark -> Chapter msg -> Story msg -> Ui msg -> Html (Msg msg)
submenuUiView bookmark chapter story ui =
    Submenu.item []
        [ case bookmark of
            UiBookmark chapterId storyId uiId ->
                if uiIdToString uiId == ui.name then
                    Submenu.linkActive [] [ text ui.name ]

                else
                    Submenu.link [ Route.href (Route.Ui chapterId storyId uiId) ] [ text ui.name ]

            _ ->
                Submenu.link [ Route.href (Route.Ui (ChapterId (Tuple.first chapter)) (StoryId (Tuple.first story)) (UiId ui.name)) ] [ text ui.name ]
        ]


contentView : Model msg -> HA.Html (Msg msg)
contentView ({ bookmark, chapters } as model) =
    case bookmark of
        None ->
            div
                [ css
                    [ Css.property "display" "grid"
                    , Css.property "justify-content" "center"
                    , Css.property "align-content" "center"
                    , fontSize (rem 2)
                    , color (rgba 0 0 0 0.5)
                    ]
                ]
                [ text "No bookmark" ]

        StoryBookmark chapterId storyId ->
            case Chapter.find (chapterIdToString chapterId) chapters of
                Just chapter ->
                    case Story.find (storyIdToString storyId) (Tuple.second chapter) of
                        Just story ->
                            submenuView bookmark chapter story

                        Nothing ->
                            div [] [ text "none" ]

                Nothing ->
                    div [] [ text "none" ]

        UiBookmark chapterId storyId uiId ->
            case Chapter.find (chapterIdToString chapterId) chapters of
                Just chapter ->
                    case Story.find (storyIdToString storyId) (Tuple.second chapter) of
                        Just story ->
                            case Ui.find (uiIdToString uiId) (Tuple.second story) of
                                Just ui ->
                                    div []
                                        [ submenuView bookmark chapter story
                                        , div [ css [ padding (px 20) ] ]
                                            [ ui.view
                                                |> HA.map ExternalMsg
                                            ]
                                        ]

                                Nothing ->
                                    div [] [ text "none" ]

                        Nothing ->
                            div [] [ text "none" ]

                Nothing ->
                    div [] [ text "none" ]

        _ ->
            span []
                [ text "BAH ALORS" ]


bodyView : Model msg -> List (H.Html (Msg msg))
bodyView ({ chapters, bookmark } as model) =
    [ global
        [ html
            [ margin zero
            , padding zero
            ]
        , body
            [ margin zero
            , padding zero
            , fontFamilies [ "Montserrat", .value serif ]
            , fontSize (px 16)
            , boxSizing borderBox
            ]
        ]
        |> toUnstyled
    , div
        [ css
            [ Css.property "display" "grid"
            , Css.property "grid-template-columns" "auto 1fr"
            , Css.height (vh 100)
            ]
        ]
        [ sidebarView bookmark chapters
        , contentView model
        ]
        |> toUnstyled
    ]


book : List (Chapter msg) -> Program () (Model msg) (Msg msg)
book chapters =
    Browser.application
        { init = init chapters
        , onUrlChange = \url -> InternalMsg (UrlChanged url)
        , onUrlRequest = \urlRequest -> InternalMsg (UrlRequested urlRequest)
        , subscriptions = always Sub.none
        , update = update
        , view = view
        }
