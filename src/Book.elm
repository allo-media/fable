module Book exposing (Model, book)

{-| With Fable you can create book of your view function.


# Definitions

@docs Chapter

-}

import Browser exposing (Document, UrlRequest)
import Browser.Navigation exposing (Key, load, pushUrl)
import Css exposing (..)
import Css.Global exposing (body, global, html)
import Data.Bookmark as BookmarkData exposing (Bookmark(..))
import Data.Chapter as Chapter exposing (Chapter, ChapterId(..), chapterIdToString, find)
import Data.Msg exposing (Internal(..), Msg(..))
import Data.Story as Story exposing (Story, StoryId(..), find, storyIdToString)
import Data.Ui as Ui exposing (Ui, UiId(..), find, uiIdToString)
import Html as H
import Html.Styled as HA exposing (..)
import Html.Styled.Attributes exposing (..)
import Route.Route as Route exposing (Route, href)
import Url exposing (Url)
import Views.App as App
import Views.Bookmark as Bookmark
import Views.Sidebar as Sidebar
import Views.Submenu as Submenu


type alias Model msg =
    { navKey : Key
    , bookmark : Bookmark
    , chapters : List (Chapter msg)
    }


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
    { title = BookmarkData.title bookmark
    , body = body model
    }


body : Model msg -> List (H.Html (Msg msg))
body ({ chapters, bookmark } as model) =
    App.view (Bookmark.view bookmark chapters)


{-| -}
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
