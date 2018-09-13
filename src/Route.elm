module Route exposing (Route(..), fromUrl, href)

import Html.Styled exposing (Attribute)
import Html.Styled.Attributes as Attributes
import Url exposing (Url)
import Url.Parser exposing ((</>), Parser, map, oneOf, parse, s, string, top)


type Route
    = Home
    | Story String String
    | Ui String String String


parser : Parser (Route -> a) a
parser =
    oneOf
        [ map Home top
        , map Story (s "chapters" </> string </> s "story" </> string)
        , map Ui (s "chapters" </> string </> s "story" </> string </> s "ui" </> string)
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

                Story chapter story ->
                    [ "chapters", chapter, "story", story ]

                Ui chapter story ui ->
                    [ "chapters", chapter, "story", story, "ui", ui ]
    in
    "#/" ++ String.join "/" pieces
