module Fable exposing (Book, app, chapter, story, ui)

{-| With Fable ....


# Definitions

@docs Chapter

-}

import Browser exposing (Document, UrlRequest)
import Browser.Navigation exposing (Key, load, pushUrl)
import Data.Bookmark as BookmarkData exposing (Bookmark(..))
import Data.Chapter as Chapter exposing (Chapter, ChapterId(..))
import Data.Msg exposing (Internal(..), Msg(..))
import Data.Story as Story exposing (Story, StoryId(..))
import Data.Ui as Ui exposing (Ui, UiId(..))
import Html as H
import Html.Styled as HS
import Route.Route as Route exposing (Route, href)
import Url exposing (Url)
import Views.App as App
import Views.Bookmark as Bookmark
import Views.Sidebar as Sidebar
import Views.Submenu as Submenu


{-| -}
type alias Book msg =
    Program () (Model msg) (Msg msg)


{-| -}
chapter : String -> List (Story msg) -> Chapter msg
chapter string stories =
    ( ChapterId string, stories )


{-| -}
story : String -> List (Ui msg) -> Story msg
story string uis =
    ( StoryId string, uis )


{-| -}
ui : String -> HS.Html msg -> Ui msg
ui string html =
    Ui (UiId string) html


{-| -}
type alias Model msg =
    { navKey : Key
    , bookmark : Bookmark
    , chapters : List (Chapter msg)
    }


{-| -}
init : List (Chapter msg) -> () -> Url -> Key -> ( Model msg, Cmd (Msg msg) )
init chapters _ url key =
    setRoute (Route.fromUrl url)
        { navKey = key
        , bookmark = None
        , chapters = chapters
        }


{-| -}
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


{-| -}
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


{-| -}
view : Model msg -> Document (Msg msg)
view ({ bookmark } as model) =
    { title = BookmarkData.title bookmark
    , body = body model
    }


{-| -}
body : Model msg -> List (H.Html (Msg msg))
body ({ chapters, bookmark } as model) =
    App.view (Bookmark.view bookmark chapters)


{-| -}
app : List (Chapter msg) -> Book msg
app chapters =
    Browser.application
        { init = init chapters
        , onUrlChange = InternalMsg << UrlChanged
        , onUrlRequest = InternalMsg << UrlRequested
        , subscriptions = always Sub.none
        , update = update
        , view = view
        }
