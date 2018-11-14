module Data.Story exposing (Id, Story, createId, find, idParser, idToString)

import Data.Ui exposing (Ui)
import Url exposing (percentDecode)
import Url.Parser exposing (Parser, custom)


type alias Story msg =
    { id : Id, uis : List (Ui msg) }


type Id
    = Id String


createId : String -> Id
createId string =
    Id string


decodeId : String -> Id
decodeId string =
    percentDecode string
        |> Maybe.withDefault string
        |> Id


find : Id -> List (Story msg) -> Maybe (Story msg)
find id stories =
    List.filter (\story -> story.id == id) stories
        |> List.head


idParser : Parser (Id -> a) a
idParser =
    custom "ID" (Just << decodeId)


idToString : Id -> String
idToString (Id id) =
    id
