module Data.Story exposing (Story, StoryId(..), find, storyIdParser, storyIdToString)

import Data.Ui exposing (Ui)
import Url exposing (percentDecode)
import Url.Parser exposing (Parser, custom)


type alias Story msg =
    ( String, List (Ui msg) )


type StoryId
    = StoryId String


decodeStoryId : String -> StoryId
decodeStoryId string =
    case percentDecode string of
        Just id ->
            StoryId id

        Nothing ->
            StoryId "invalid"


find : String -> List (Story msg) -> Maybe (Story msg)
find id stories =
    List.filter (\story -> Tuple.first story == id) stories
        |> List.head


storyIdParser : Parser (StoryId -> a) a
storyIdParser =
    custom "STORY_ID" (Just << decodeStoryId)


storyIdToString : StoryId -> String
storyIdToString (StoryId id) =
    id
