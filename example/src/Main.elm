module Main exposing (main)

import Fable exposing (Book, app, chapter, story, ui)
import Html.Styled exposing (text)
import Ui.Button as Button
import Ui.Input as Input
import Ui.Panel as Panel


type Msg
    = NoOp


main : Book Msg
main =
    app
        [ chapter "Forms"
            [ story "Inputs"
                [ ui "Default" (Input.default [] [])
                , ui "Small" (Input.small [] [])
                ]
            , story "Button"
                [ ui "Default" (Button.default [] [ text "Default" ])
                , ui "Multiple"
                    (Button.multiple []
                        [ Button.default [] [ text "Default" ]
                        , Button.primary [] [ text "Sign in" ]
                        , Button.danger [] [ text "Alert ! This button delete internet !" ]
                        , Button.warning [] [ text "Warning !" ]
                        ]
                    )
                ]
            , story "Panel"
                [ ui "Default"
                    (Panel.default []
                        [ Panel.head [] [ text "Donec consequat diam" ]
                        , Panel.content [] [ text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at tortor nec leo vestibulum varius. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Cras elementum odio eu lectus iaculis pretium. Nulla vel velit venenatis, hendrerit nisl sit amet, placerat erat. Duis consectetur ante felis, ac auctor diam maximus vel. Phasellus scelerisque justo arcu, et dignissim ex laoreet non. Aenean sit amet sem sit amet eros aliquam placerat. Maecenas id viverra risus. Mauris tempor dui non commodo ornare. Mauris congue dignissim dolor quis auctor. Quisque eu erat orci. Mauris quis pretium justo, vitae gravida diam.\n\nDonec consequat diam mattis pellentesque tempus. Maecenas et interdum nisl, sit amet molestie felis. Donec euismod rhoncus enim, vel facilisis enim finibus vel. Sed sit amet diam leo. Fusce tincidunt eros quis imperdiet feugiat. Aliquam facilisis tellus fermentum tellus malesuada, ac sagittis metus volutpat. Cras eget interdum lorem. Praesent dignissim tellus eu venenatis sollicitudin. In sed volutpat mauris. Nulla venenatis sed augue sed iaculis.\n\n" ]
                        ]
                    )
                ]
            ]
        ]
