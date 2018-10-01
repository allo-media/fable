module Data.Ui exposing (Ui, UiId(..), find, uiIdParser, uiIdToString)

import Html.Styled exposing (Html)
import Url exposing (percentDecode)
import Url.Parser exposing (Parser, custom)


type alias Ui msg =
    { name : String
    , view : Html msg
    }


type UiId
    = UiId String


decodeUiId : String -> UiId
decodeUiId string =
    case percentDecode string of
        Just id ->
            UiId id

        Nothing ->
            UiId ""


find : String -> List (Ui msg) -> Maybe (Ui msg)
find name uis =
    List.filter (\ui -> ui.name == name) uis
        |> List.head


uiIdParser : Parser (UiId -> a) a
uiIdParser =
    custom "UI_ID" (Just << decodeUiId)


uiIdToString : UiId -> String
uiIdToString (UiId id) =
    id
