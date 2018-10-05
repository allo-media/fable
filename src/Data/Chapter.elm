module Data.Chapter exposing (Chapter, ChapterId(..), find, idParser, idToString)

import Data.Story exposing (Story)
import Url exposing (percentDecode)
import Url.Parser exposing (Parser, custom)


type alias Chapter msg =
    ( ChapterId, List (Story msg) )


type ChapterId
    = ChapterId String


idParser : Parser (ChapterId -> a) a
idParser =
    custom "CHAPTER_ID" (Just << decodeId)


idToString : ChapterId -> String
idToString (ChapterId id) =
    id


decodeId : String -> ChapterId
decodeId string =
    case percentDecode string of
        Just id ->
            ChapterId id

        Nothing ->
            ChapterId string


find : ChapterId -> List (Chapter msg) -> Maybe (Chapter msg)
find id chapts =
    List.filter (\( id_, _ ) -> id_ == id) chapts
        |> List.head
