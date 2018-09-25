module Book exposing (Chapter, Story, Ui, bind)

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



{- Types -}


type alias Chapter =
    ( String, List Story )


type alias Story =
    ( String, List Ui )


type alias Ui =
    { name : String
    , view : Html Msg
    }


type Bookmark
    = ChapterBookmark Chapter
    | StoryBookmark Chapter Story
    | UiBookmark Chapter Story Ui
    | None


type alias Model =
    { navKey : Key
    , bookmark : Bookmark
    , chapters : List Chapter
    }


type Msg
    = UrlChanged Url
    | UrlRequested Browser.UrlRequest
    | NoOp


selectChapter : String -> List Chapter -> Maybe Chapter
selectChapter id chapts =
    List.filter (\( title, _ ) -> title == id) chapts
        |> List.head


selectStory : String -> Chapter -> Maybe Story
selectStory id (( title, stories ) as chapter) =
    List.filter (\story -> Tuple.first story == id) stories
        |> List.head


selectUi : String -> Story -> Maybe Ui
selectUi name (( title, uis ) as storie) =
    List.filter (\ui -> ui.name == name) uis
        |> List.head


init : List Chapter -> () -> Url -> Key -> ( Model, Cmd Msg )
init chap _ url key =
    setRoute (Route.fromUrl url)
        { navKey = key
        , bookmark = None
        , chapters = chap
        }


setUiBookmark : String -> String -> String -> Model -> Bookmark
setUiBookmark chapterId storyId uiId ({ chapters } as model) =
    case selectChapter chapterId chapters of
        Nothing ->
            None

        Just chapter ->
            case selectStory storyId chapter of
                Nothing ->
                    None

                Just story ->
                    selectUi uiId story
                        |> Maybe.map (UiBookmark chapter story)
                        |> Maybe.withDefault None


setStoryBookmark : String -> String -> Model -> Bookmark
setStoryBookmark chapterId storyId ({ chapters } as model) =
    case selectChapter chapterId chapters of
        Nothing ->
            None

        Just chapter ->
            selectStory storyId chapter
                |> Maybe.map (StoryBookmark chapter)
                |> Maybe.withDefault None


setRoute : Maybe Route -> Model -> ( Model, Cmd Msg )
setRoute route ({ chapters } as model) =
    case route of
        Nothing ->
            ( model, Cmd.none )

        Just (Route.Story chapterId storyId) ->
            ( { model | bookmark = setStoryBookmark chapterId storyId model }
            , Cmd.none
            )

        Just (Route.Ui chapterId storyId uiId) ->
            ( { model | bookmark = setUiBookmark chapterId storyId uiId model }
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
documentTitle ({ bookmark } as model) =
    case bookmark of
        None ->
            ""

        StoryBookmark chapter story ->
            Tuple.first story
                |> (++) " :: "
                |> (++) (Tuple.first chapter)

        UiBookmark chapter story ui ->
            ui.name
                |> (++) " :: "
                |> (++) (Tuple.first story)
                |> (++) " :: "
                |> (++) (Tuple.first chapter)

        _ ->
            ""


sidebarStoryView : Bookmark -> Chapter -> Story -> Html msg
sidebarStoryView bookmark (( chapterTitle, _ ) as chapter) (( storyTitle, _ ) as story) =
    let
        active =
            case bookmark of
                StoryBookmark chapterBookmark storyBookmark ->
                    if storyTitle == Tuple.first storyBookmark then
                        span
                            [ css
                                [ display block
                                , padding (px 5)
                                , cursor pointer
                                , color (rgb 255 255 255)
                                , textDecoration none
                                , hover
                                    [ backgroundColor (rgb 99 167 245)
                                    , borderRadius (px 3)
                                    ]
                                , backgroundColor (rgba 99 167 245 0.8)
                                , borderRadius (px 3)
                                ]
                            ]
                            [ text storyTitle ]

                    else
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

                UiBookmark _ storyBookmark ui ->
                    if storyTitle == Tuple.first storyBookmark then
                        span
                            [ css
                                [ display block
                                , padding (px 5)
                                , cursor pointer
                                , color (rgb 255 255 255)
                                , textDecoration none
                                , hover
                                    [ backgroundColor (rgb 99 167 245)
                                    , borderRadius (px 3)
                                    ]
                                , backgroundColor (rgba 99 167 245 0.8)
                                , borderRadius (px 3)
                                ]
                            ]
                            [ text storyTitle ]

                    else
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

                _ ->
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
    in
    li [] [ active ]


sidebarChapterView : Bookmark -> Chapter -> Html msg
sidebarChapterView bookmark (( title, stories ) as chapter) =
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
        , List.map (sidebarStoryView bookmark chapter) stories
            |> ul
                [ css
                    [ listStyle none
                    , padding zero
                    ]
                ]
        ]


sidebarView : Bookmark -> List Chapter -> Html msg
sidebarView bookmark chapters =
    div
        [ css
            [ backgroundColor (rgb 47 51 56)
            , Css.width (pct 100)
            , Css.height (pct 100)
            , displayFlex
            , justifyContent center
            ]
        ]
        [ List.map (sidebarChapterView bookmark) chapters
            |> ul
                [ css
                    [ listStyle none
                    , padding (px 10)
                    , Css.width (px 200)
                    , marginTop (px 30)
                    ]
                ]
        ]


submenuView : Bookmark -> Chapter -> Story -> Html msg
submenuView bookmark chapter story =
    div []
        [ List.map (submenuUiView bookmark chapter story) (Tuple.second story)
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
        ]


submenuUiView : Bookmark -> Chapter -> Story -> Ui -> Html msg
submenuUiView bookmark chapter story ui =
    let
        active =
            case bookmark of
                UiBookmark chapterBookmark storyBookmark uiBookmark ->
                    if uiBookmark.name == ui.name then
                        span
                            [ Route.href (Route.Ui (Tuple.first chapter) (Tuple.first story) ui.name)
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
                                , borderBottom3 (px 3) solid (rgba 99 167 245 1)
                                , hover
                                    [ borderBottom3 (px 3) solid (rgba 99 167 245 0.8)
                                    ]
                                ]
                            ]
                            [ text ui.name ]

                    else
                        a
                            [ Route.href (Route.Ui (Tuple.first chapter) (Tuple.first story) ui.name)
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

                _ ->
                    a
                        [ Route.href (Route.Ui (Tuple.first chapter) (Tuple.first story) ui.name)
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
                            , borderBottom3 (px 3) solid (rgba 255 255 255 1)
                            , hover
                                [ borderBottom3 (px 3) solid (rgba 99 167 245 0.8)
                                ]
                            ]
                        ]
                        [ text ui.name ]
    in
    li
        [ css
            [ minWidth (px 80) ]
        ]
        [ active ]


contentView : Model -> HA.Html Msg
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

        StoryBookmark chapter story ->
            submenuView bookmark chapter story

        UiBookmark chapter story ui ->
            div []
                [ submenuView bookmark chapter story
                , div [ css [ padding (px 20) ] ]
                    [ ui.view |> HA.map (\_ -> NoOp)
                    ]
                ]

        _ ->
            div [] []


bodyView : Model -> List (H.Html Msg)
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


bind : List Chapter -> Program () Model Msg
bind chapters =
    Browser.application
        { init = init chapters
        , onUrlChange = UrlChanged
        , onUrlRequest = UrlRequested
        , subscriptions = always Sub.none
        , update = update
        , view = view
        }


{-| Example of code
-}
chapterList : List Chapter
chapterList =
    [ ( "Forms"
      , [ ( "Buttons"
          , [ { name = "Button", view = buttonView "button" }
            , { name = "Button2", view = buttonView "button 2" }
            ]
          )
        , ( "Inputs"
          , [ { name = "Default", view = div [] [] }
            , { name = "Small", view = div [] [] }
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
    bind chapterList
