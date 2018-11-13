module Data.Ui exposing (Id, Ui, createId, find, idParser, idToString)

import Html.Styled exposing (Html)
import Url exposing (percentDecode)
import Url.Parser exposing (Parser, custom)


type alias Ui msg =
    { id : Id
    , view : Html msg
    }


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


find : Id -> List (Ui msg) -> Maybe (Ui msg)
find id uis =
    List.filter (\ui -> ui.id == id) uis
        |> List.head


idParser : Parser (Id -> a) a
idParser =
    custom "ID" (Just << decodeId)


idToString : Id -> String
idToString (Id id) =
    id
