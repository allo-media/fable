module Views.Theme exposing (Element)

import Html.Styled exposing (Attribute, Html)


type alias Element msg =
    List (Attribute msg) -> List (Html msg) -> Html msg
