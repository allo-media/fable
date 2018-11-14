module Data.Chapter exposing (Chapter, Id, createId, find, idParser, idToString)

import Data.Story exposing (Story)
import Url exposing (percentDecode)
import Url.Parser exposing (Parser, custom)


type alias Chapter msg =
    { id : Id
    , stories : List (Story msg)
    }


type Id
    = Id String


createId : String -> Id
createId string =
    Id string


idParser : Parser (Id -> a) a
idParser =
    custom "ID" (Just << decodeId)


idToString : Id -> String
idToString (Id id) =
    id


decodeId : String -> Id
decodeId string =
    percentDecode string
        |> Maybe.withDefault string
        |> Id


find : Id -> List (Chapter msg) -> Maybe (Chapter msg)
find id chapts =
    List.filter (\chapter -> chapter.id == id) chapts
        |> List.head
