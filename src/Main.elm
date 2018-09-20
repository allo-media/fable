module Main exposing (Chapter, Story, Ui, book)

import Browser exposing (Document, UrlRequest)
import Browser.Navigation exposing (Key, load, pushUrl)
import Css exposing (..)
import Css.Global exposing (body, global, html)
import Html as H
import Html.Styled as HA exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (onClick)
import Route exposing (Route, href)
import Url exposing (Url)
import Views.Ui.Input as Input



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
    li []
        [ a
            [ Route.href (Route.Story chapterTitle storyTitle)
            , css
                [ display block
                , padding (px 5)
                , cursor pointer
                , color (rgb 255 255 255)
                , textDecoration none
                , hover
                    [ backgroundColor (rgb 99 167 245)
                    , borderRadius (px 3)
                    ]
                ]
            ]
            [ text storyTitle ]
        ]


menuChapterView : Chapter -> Html msg
menuChapterView ( title, stories ) =
    li []
        [ span
            [ css
                [ color (rgb 255 255 255)
                , padding2 (px 10) (px 5)
                , marginBottom (px 10)
                , borderBottom2 (px 1) dotted
                , display block
                ]
            ]
            [ text title ]
        , List.map (menuStoriesView title) stories
            |> ul
                [ css
                    [ listStyle none
                    , padding zero
                    ]
                ]
        ]


menuChaptersView : List Chapter -> Html msg
menuChaptersView chapters =
    div
        [ css
            [ backgroundColor (rgb 47 51 56)
            , Css.width (pct 100)
            , Css.height (pct 100)
            , displayFlex
            , justifyContent center
            ]
        ]
        [ List.map menuChapterView chapters
            |> ul
                [ css
                    [ listStyle none, padding (px 10), Css.width (px 200), marginTop (px 30) ]
                ]
        ]


uiItemView : Chapter -> String -> Ui -> Html msg
uiItemView chapter story ui =
    li
        [ css
            [ minWidth (px 80)
            , first
                [ margin4 zero zero zero (px 20) ]
            ]
        ]
        [ a
            [ Route.href (Route.Ui (Tuple.first chapter) story ui.name)
            , css
                [ textDecoration none
                , backgroundColor (rgb 255 255 255)
                , Css.width (px 80)
                , Css.height (px 30)
                , Css.property "display" "grid"
                , Css.property "align-items" "center"
                , textAlign center
                , color (rgb 0 0 0)
                , padding (px 10)
                , borderBottom3 (px 3) solid (rgb 255 255 255)
                , hover
                    [ borderBottom3 (px 3) solid (rgba 99 167 245 0.8)
                    ]
                ]
            ]
            [ text ui.name ]
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
        [ List.map (uiItemView selectedChapter storyName) uis
            |> ul
                [ css
                    [ backgroundColor (rgb 248 248 248)
                    , borderBottom3 (px 1) solid (rgb 181 181 181)
                    , margin zero
                    , Css.height (px 80)
                    , Css.property "display" "grid"
                    , Css.property "grid-auto-flow" "column"
                    , Css.property "justify-content" "flex-start"
                    , Css.property "align-items" "flex-end"
                    , listStyle none
                    , padding zero
                    , Css.width (pct 100)
                    ]
                ]
        , div
            [ css
                [ padding (px 20)
                ]
            ]
            [ ui.view |> HA.map (\_ -> NoOp)
            ]
        ]


bodyView : Model -> List (H.Html Msg)
bodyView model =
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
        [ menuChaptersView model.chapters
        , contentView model
        ]
        |> toUnstyled
    ]


book : List Chapter -> Program () Model Msg
book chapters =
    Browser.application
        { init = init chapters
        , onUrlChange = UrlChanged
        , onUrlRequest = UrlRequested
        , subscriptions = always Sub.none
        , update = update
        , view = view
        }


chapterList : List Chapter
chapterList =
    [ ( "Forms"
      , [ ( "Buttons"
          , [ { name = "Button", view = buttonView "button" }
            , { name = "Button2", view = buttonView "button 2" }
            ]
          )
        , ( "Inputs"
          , [ { name = "Default", view = Input.default [] [] }
            , { name = "Small", view = Input.small [] [] }
            ]
          )
        ]
      )
    ]


buttonView : String -> Html msg
buttonView string =
    button [] [ text string ]


main : Program () Model Msg
main =
    book chapterList
