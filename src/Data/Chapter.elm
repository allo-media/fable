module Data.Chapter exposing (Chapter, ChapterId(..), chapterIdParser, chapterIdToString, find)

import Data.Story exposing (Story)
import Url exposing (percentDecode)
import Url.Parser exposing (Parser, custom)


type alias Chapter msg =
    ( String, List (Story msg) )


type ChapterId
    = ChapterId String


chapterIdParser : Parser (ChapterId -> a) a
chapterIdParser =
    custom "CHAPTER_ID" (Just << decodeChapterId)


chapterIdToString : ChapterId -> String
chapterIdToString (ChapterId id) =
    id


decodeChapterId : String -> ChapterId
decodeChapterId string =
    case percentDecode string of
        Just id ->
            ChapterId id

        Nothing ->
            ChapterId ""


find : String -> List (Chapter msg) -> Maybe (Chapter msg)
find id chapts =
    List.filter (\( title, _ ) -> title == id) chapts
        |> List.head
