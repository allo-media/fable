module Data.Story exposing (Story, StoryId(..), find, idParser, idToString)

import Data.Ui exposing (Ui)
import Url exposing (percentDecode)
import Url.Parser exposing (Parser, custom)


type alias Story msg =
    ( StoryId, List (Ui msg) )


type StoryId
    = StoryId String


decodeId : String -> StoryId
decodeId string =
    case percentDecode string of
        Just id ->
            StoryId id

        Nothing ->
            StoryId string


find : StoryId -> List (Story msg) -> Maybe (Story msg)
find id stories =
    List.filter (\story -> Tuple.first story == id) stories
        |> List.head


idParser : Parser (StoryId -> a) a
idParser =
    custom "STORY_ID" (Just << decodeId)


idToString : StoryId -> String
idToString (StoryId id) =
    id
