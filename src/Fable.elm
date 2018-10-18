module Fable exposing
    ( app
    , Book, chapter, story, ui
    )

{-| Fable allows you to create a book (like a repository) of your html views, they are grouped as chapters, stories.


# App

@docs app


# Model

@docs book


# Element

@doc chapter
@doc story
@doc ui

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


{-| Book application type

    main : Book Msg
    main =
        let
            chapters =
                [ Fable.chapter "chapter1" [] ]
        in
        Fable.app chapters

-}
type alias Book msg =
    Program () (Model msg) (Msg msg)


{-| Chapter represents a category like Forms, Blocks, or whatever. It needs an unique id.

      chapters = [
        Fable.chapter "chapter 1" []
      ]

-}
chapter : String -> List (Story msg) -> Chapter msg
chapter string stories =
    { id = ChapterId string, stories = stories }


{-| Story represents a list of element html (like input with different state). It needs an unique id.

      stories = [
        Fable.story "story 1" []
      ]

-}
story : String -> List (Ui msg) -> Story msg
story string uis =
    { id = StoryId string, uis = uis }


{-| Ui represents an element of your view. It needs an unique id.

      ui = [
        Fable.ui "ui 1" (div [] [])
      ]

-}
ui : String -> HS.Html msg -> Ui msg
ui string html =
    Ui (UiId string) html


{-| Launch a fable application with a list of chapters

      main : Book Msg
      main =
          Fable.app []

-}
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
            let
                bookmark =
                    Chapter.find chapterId model.chapters
                        |> Maybe.andThen (\chapter_ -> Story.find storyId chapter_.stories)
                        |> Maybe.andThen (\storie_ -> List.head storie_.uis)
                        |> Maybe.map (\ui_ -> UiBookmark chapterId storyId ui_.id)
                        |> Maybe.withDefault (StoryBookmark chapterId storyId)
            in
            ( { model | bookmark = bookmark }, Cmd.none )

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
