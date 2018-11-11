module Route.Route exposing (Route(..), fromUrl, href)

import Data.Chapter as Chapter exposing (ChapterId(..))
import Data.Story as Story exposing (StoryId(..))
import Data.Ui as Ui exposing (UiId(..))
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
        , map Chapter (s "chapters" </> Chapter.idParser)
        , map Story (s "chapters" </> Chapter.idParser </> s "story" </> Story.idParser)
        , map Ui (s "chapters" </> Chapter.idParser </> s "story" </> Story.idParser </> s "ui" </> Ui.idParser)
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
                    [ "chapters", chapterId |> Chapter.idToString |> percentEncode ]

                Story chapterId storyId ->
                    [ "chapters"
                    , chapterId |> Chapter.idToString |> percentEncode
                    , "story"
                    , storyId |> Story.idToString |> percentEncode
                    ]

                Ui chapterId storyId uiId ->
                    [ "chapters"
                    , chapterId |> Chapter.idToString |> percentEncode
                    , "story"
                    , storyId |> Story.idToString |> percentEncode
                    , "ui"
                    , uiId |> Ui.idToString |> percentEncode
                    ]
    in
    "#/" ++ String.join "/" pieces
