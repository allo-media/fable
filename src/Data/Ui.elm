module Data.Ui exposing (Ui, UiId(..), find, idParser, idToString)

import Html.Styled exposing (Html)
import Url exposing (percentDecode)
import Url.Parser exposing (Parser, custom)


type alias Ui msg =
    { id : UiId
    , view : Html msg
    }


type UiId
    = UiId String


decodeId : String -> UiId
decodeId string =
    case percentDecode string of
        Just id ->
            UiId id

        Nothing ->
            UiId string


find : UiId -> List (Ui msg) -> Maybe (Ui msg)
find id uis =
    List.filter (\ui -> ui.id == id) uis
        |> List.head


idParser : Parser (UiId -> a) a
idParser =
    custom "UI_ID" (Just << decodeId)


idToString : UiId -> String
idToString (UiId id) =
    id
