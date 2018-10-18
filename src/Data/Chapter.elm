module Data.Chapter exposing (Chapter, ChapterId(..), find, idParser, idToString)

import Data.Story exposing (Story)
import Url exposing (percentDecode)
import Url.Parser exposing (Parser, custom)


type alias Chapter msg =
    { id : ChapterId
    , stories : List (Story msg)
    }


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
    percentDecode string
        |> Maybe.withDefault string
        |> ChapterId


find : ChapterId -> List (Chapter msg) -> Maybe (Chapter msg)
find id chapts =
    List.filter (\chapter -> chapter.id == id) chapts
        |> List.head
