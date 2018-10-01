module Route.Route exposing (Route(..), fromUrl, href)

import Data.Chapter exposing (ChapterId, chapterIdParser, chapterIdToString)
import Data.Story exposing (StoryId, storyIdParser, storyIdToString)
import Data.Ui exposing (UiId, uiIdParser, uiIdToString)
import Html.Styled exposing (Attribute)
import Html.Styled.Attributes as Attributes
import Url exposing (Url, percentEncode)
import Url.Parser exposing ((</>), Parser, map, oneOf, parse, s, string, top)


type Route
    = Home
    | Chapter ChapterId
    | Story ChapterId StoryId
    | Ui ChapterId StoryId UiId


parser : Parser (Route -> a) a
parser =
    oneOf
        [ map Home top
        , map Chapter (s "chapters" </> chapterIdParser)
        , map Story (s "chapters" </> chapterIdParser </> s "story" </> storyIdParser)
        , map Ui (s "chapters" </> chapterIdParser </> s "story" </> storyIdParser </> s "ui" </> uiIdParser)
        ]


href : Route -> Attribute msg
href route =
    Attributes.href (routeToString route)


fromUrl : Url -> Maybe Route
fromUrl url =
    { url | path = Maybe.withDefault "" url.fragment, fragment = Nothing }
        |> parse parser


routeToString : Route -> String
routeToString route =
    let
        pieces =
            case route of
                Home ->
                    []

                Chapter chapterId ->
                    [ "chapters", chapterId |> chapterIdToString |> percentEncode ]

                Story chapterId storyId ->
                    [ "chapters"
                    , chapterId |> chapterIdToString |> percentEncode
                    , "story"
                    , storyId |> storyIdToString |> percentEncode
                    ]

                Ui chapterId storyId uiId ->
                    [ "chapters"
                    , chapterId |> chapterIdToString |> percentEncode
                    , "story"
                    , storyId |> storyIdToString |> percentEncode
                    , "ui"
                    , uiId |> uiIdToString |> percentEncode
                    ]
    in
    "#/" ++ String.join "/" pieces
