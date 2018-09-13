module Main exposing (Chapter, Story, Ui, app)

import Browser exposing (Document, UrlRequest)
import Browser.Navigation exposing (Key, load, pushUrl)
import Css exposing (..)
import Html as H
import Html.Styled as HA exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (onClick)
import Route exposing (Route, href)
import Url exposing (Url)



{- Types -}


type alias Chapter =
    ( String, List Story )


type alias Story =
    ( String, List Ui )


type alias Ui =
    { name : String
    , view : Html Msg
    }


type alias Model =
    { navKey : Key
    , selectStory : String
    , selectChapter : String
    , selectUi : String
    , chapters : List Chapter
    }


type Msg
    = UrlChanged Url
    | UrlRequested Browser.UrlRequest
    | NoOp


selectChapter : String -> List ( String, List Story ) -> Chapter
selectChapter id chapts =
    List.filter (\( title, _ ) -> title == id) chapts
        |> List.head
        |> Maybe.withDefault ( "Nothing", [] )


selectStory : String -> List Story -> Story
selectStory id storyList =
    List.filter (\story -> Tuple.first story == id) storyList
        |> List.head
        |> Maybe.withDefault ( "Nothing", [] )


selectUi : String -> List Ui -> Ui
selectUi name uis =
    List.filter (\ui -> ui.name == name) uis
        |> List.head
        |> Maybe.withDefault { name = "Nothing", view = div [] [] }


init : List Chapter -> () -> Url -> Key -> ( Model, Cmd Msg )
init chap _ url key =
    setRoute (Route.fromUrl url)
        { navKey = key
        , selectStory = ""
        , selectChapter = ""
        , selectUi = ""
        , chapters = chap
        }


setRoute : Maybe Route -> Model -> ( Model, Cmd Msg )
setRoute route model =
    case route of
        Nothing ->
            ( model, Cmd.none )

        Just (Route.Story chapterId storyId) ->
            let
                selectedChapter =
                    selectChapter chapterId model.chapters

                selectedStory =
                    selectStory storyId (Tuple.second selectedChapter)
            in
            ( { model
                | selectChapter = Tuple.first selectedChapter
                , selectStory = Tuple.first selectedStory
              }
            , Cmd.none
            )

        Just (Route.Ui chapterId storyId ui) ->
            let
                selectedChapter =
                    selectChapter chapterId model.chapters

                selectedStory =
                    selectStory storyId (Tuple.second selectedChapter)

                selectedUi =
                    selectUi ui (Tuple.second selectedStory)
            in
            ( { model
                | selectChapter = Tuple.first selectedChapter
                , selectStory = Tuple.first selectedStory
                , selectUi = selectedUi.name
              }
            , Cmd.none
            )

        Just Route.Home ->
            ( model, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
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


view : Model -> Document Msg
view model =
    { title = documentTitle model
    , body = bodyView model
    }


documentTitle : Model -> String
documentTitle model =
    let
        chapter =
            selectChapter model.selectChapter model.chapters

        story =
            selectStory model.selectStory (Tuple.second chapter)

        ui =
            selectUi model.selectUi (Tuple.second story)
    in
    if Tuple.first chapter == "Nothing" then
        "Home"

    else
        ui.name
            |> (++) " :: "
            |> (++) (Tuple.first story)
            |> (++) " :: "
            |> (++) (Tuple.first chapter)


menuStoriesView : String -> Story -> Html msg
menuStoriesView chapterTitle ( storyTitle, _ ) =
    li [] [ a [ Route.href (Route.Story chapterTitle storyTitle) ] [ text storyTitle ] ]


menuChapterView : Chapter -> Html msg
menuChapterView ( title, stories ) =
    li []
        [ span [] [ text title ]
        , List.map (menuStoriesView title) stories
            |> ul []
        ]


menuChaptersView : List Chapter -> Html msg
menuChaptersView chapters =
    div []
        [ List.map menuChapterView chapters
            |> ul
                [ css
                    [ listStyle none ]
                ]
        ]


contentView : Model -> HA.Html Msg
contentView model =
    let
        selectedChapter =
            selectChapter model.selectChapter model.chapters

        ( storyName, uis ) =
            selectStory model.selectStory (Tuple.second selectedChapter)

        ui =
            selectUi model.selectUi uis
    in
    div []
        [ List.map (\u -> li [] [ a [ Route.href (Route.Ui (Tuple.first selectedChapter) storyName u.name) ] [ text u.name ] ]) uis
            |> ul []
        , div []
            [ ui.view |> HA.map (\_ -> NoOp)
            ]
        ]


bodyView : Model -> List (H.Html Msg)
bodyView model =
    [ div
        [ css
            [ Css.property "display" "grid"
            , Css.property "grid-template-columns" "auto 1fr"
            ]
        ]
        [ menuChaptersView model.chapters
        , contentView model
        ]
        |> toUnstyled
    ]


app : List Chapter -> Program () Model Msg
app chapters =
    Browser.application
        { init = init chapters
        , onUrlChange = UrlChanged
        , onUrlRequest = UrlRequested
        , subscriptions = \model -> Sub.none
        , update = update
        , view = view
        }


chapterList : List Chapter
chapterList =
    [ ( "Forms"
      , [ ( "Buttons", [ { name = "Button", view = buttonView "button" }, { name = "Button2", view = buttonView "button 2" } ] )
        , ( "Inputs", [ { name = "Input", view = buttonView "input" } ] )
        ]
      )
    ]


buttonView : String -> Html msg
buttonView string =
    button [] [ text string ]


main : Program () Model Msg
main =
    app chapterList
