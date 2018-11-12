module Main exposing (main)

import Css exposing (..)
import Fable as Fable exposing (Book)
import Html.Styled exposing (Html, button, input, text)
import Html.Styled.Attributes exposing (css)
import Html.Styled.Events exposing (..)
import Ui.Button as Button
import Ui.Input as Input
import Ui.Panel as Panel


type Msg
    = NoOp


main : Book Msg
main =
    let
        chapters =
            [ Fable.chapter "Forms"
                [ Fable.story "Inputs"
                    [ Fable.ui "Default" (Input.default [] [])
                    , Fable.ui "Small" (Input.small [] [])
                    , Fable.ui "Medium" (Input.medium [] [])
                    , Fable.ui "FullWidth" (Input.fullWidth [] [])
                    , Fable.ui "Valid" (Input.valid [] [])
                    , Fable.ui "Invalid" (Input.invalid [] [])
                    ]
                , Fable.story "Button"
                    [ Fable.ui "Default" (Button.default [] [ text "Default" ])
                    , Fable.ui "Primary" (Button.primary [] [ text "Sign in" ])
                    , Fable.ui "Danger" (Button.danger [] [ text "Alert ! This button delete internet !" ])
                    , Fable.ui "Warning" (Button.warning [] [ text "Warning !" ])
                    , Fable.ui "Multiple"
                        (Button.multiple []
                            [ Button.default [] [ text "Default" ]
                            , Button.primary [] [ text "Sign in" ]
                            , Button.danger [] [ text "Alert ! This button delete internet !" ]
                            , Button.warning [] [ text "Warning !" ]
                            ]
                        )
                    , Fable.ui "Multiple center"
                        (Button.multipleCenter []
                            [ Button.default [] [ text "Default" ]
                            , Button.primary [] [ text "Sign in" ]
                            , Button.danger [] [ text "Alert ! This button delete internet !" ]
                            , Button.warning [] [ text "Warning !" ]
                            ]
                        )
                    , Fable.ui "Multiple Right"
                        (Button.multipleRight []
                            [ Button.default [] [ text "Default" ]
                            , Button.primary [] [ text "Sign in" ]
                            , Button.danger [] [ text "Alert ! This button delete internet !" ]
                            , Button.warning [] [ text "Warning !" ]
                            ]
                        )
                    ]
                , Fable.story "Panel"
                    [ Fable.ui "Default"
                        (Panel.default []
                            [ Panel.head [] [ text "Donec consequat diam" ]
                            , Panel.content [] [ text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at tortor nec leo vestibulum varius. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Cras elementum odio eu lectus iaculis pretium. Nulla vel velit venenatis, hendrerit nisl sit amet, placerat erat. Duis consectetur ante felis, ac auctor diam maximus vel. Phasellus scelerisque justo arcu, et dignissim ex laoreet non. Aenean sit amet sem sit amet eros aliquam placerat. Maecenas id viverra risus. Mauris tempor dui non commodo ornare. Mauris congue dignissim dolor quis auctor. Quisque eu erat orci. Mauris quis pretium justo, vitae gravida diam.\n\nDonec consequat diam mattis pellentesque tempus. Maecenas et interdum nisl, sit amet molestie felis. Donec euismod rhoncus enim, vel facilisis enim finibus vel. Sed sit amet diam leo. Fusce tincidunt eros quis imperdiet feugiat. Aliquam facilisis tellus fermentum tellus malesuada, ac sagittis metus volutpat. Cras eget interdum lorem. Praesent dignissim tellus eu venenatis sollicitudin. In sed volutpat mauris. Nulla venenatis sed augue sed iaculis.\n\n" ]
                            ]
                        )
                    , Fable.ui "Head"
                        (Panel.default []
                            [ Panel.head [] [ text "In sed volutpat mauris" ]
                            , Panel.content [] [ text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at tortor nec leo vestibulum varius. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Cras elementum odio eu lectus iaculis pretium. Nulla vel velit venenatis, hendrerit nisl sit amet, placerat erat. Duis consectetur ante felis, ac auctor diam maximus vel. Phasellus scelerisque justo arcu, et dignissim ex laoreet non. Aenean sit amet sem sit amet eros aliquam placerat. Maecenas id viverra risus. Mauris tempor dui non commodo ornare. Mauris congue dignissim dolor quis auctor. Quisque eu erat orci. Mauris quis pretium justo, vitae gravida diam.\n\nDonec consequat diam mattis pellentesque tempus. Maecenas et interdum nisl, sit amet molestie felis. Donec euismod rhoncus enim, vel facilisis enim finibus vel. Sed sit amet diam leo. Fusce tincidunt eros quis imperdiet feugiat. Aliquam facilisis tellus fermentum tellus malesuada, ac sagittis metus volutpat. Cras eget interdum lorem. Praesent dignissim tellus eu venenatis sollicitudin. In sed volutpat mauris. Nulla venenatis sed augue sed iaculis.\n\n" ]
                            , Panel.foot []
                                [ Button.multipleRight []
                                    [ Button.default [] [ text "Cancel" ]
                                    , Button.primary [] [ text "Confirm" ]
                                    ]
                                ]
                            ]
                        )
                    ]
                ]
            , Fable.chapter "Forms 1"
                [ Fable.story "Inputs"
                    [ Fable.ui "Default" (Input.default [] [])
                    , Fable.ui "Small" (Input.small [] [])
                    , Fable.ui "Medium" (Input.medium [] [])
                    , Fable.ui "FullWidth" (Input.fullWidth [] [])
                    , Fable.ui "Valid" (Input.valid [] [])
                    , Fable.ui "Invalid" (Input.invalid [] [])
                    ]
                , Fable.story "Button"
                    [ Fable.ui "Default" (Button.default [] [ text "Default" ])
                    , Fable.ui "Primary" (Button.primary [] [ text "Sign in" ])
                    , Fable.ui "Danger" (Button.danger [] [ text "Alert ! This button delete internet !" ])
                    , Fable.ui "Warning" (Button.warning [] [ text "Warning !" ])
                    , Fable.ui "Multiple"
                        (Button.multiple []
                            [ Button.default [] [ text "Default" ]
                            , Button.primary [] [ text "Sign in" ]
                            , Button.danger [] [ text "Alert ! This button delete internet !" ]
                            , Button.warning [] [ text "Warning !" ]
                            ]
                        )
                    , Fable.ui "Multiple center"
                        (Button.multipleCenter []
                            [ Button.default [] [ text "Default" ]
                            , Button.primary [] [ text "Sign in" ]
                            , Button.danger [] [ text "Alert ! This button delete internet !" ]
                            , Button.warning [] [ text "Warning !" ]
                            ]
                        )
                    , Fable.ui "Multiple Right"
                        (Button.multipleRight []
                            [ Button.default [] [ text "Default" ]
                            , Button.primary [] [ text "Sign in" ]
                            , Button.danger [] [ text "Alert ! This button delete internet !" ]
                            , Button.warning [] [ text "Warning !" ]
                            ]
                        )
                    ]
                , Fable.story "Panel"
                    [ Fable.ui "Default"
                        (Panel.default []
                            [ Panel.head [] [ text "Donec consequat diam" ]
                            , Panel.content [] [ text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at tortor nec leo vestibulum varius. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Cras elementum odio eu lectus iaculis pretium. Nulla vel velit venenatis, hendrerit nisl sit amet, placerat erat. Duis consectetur ante felis, ac auctor diam maximus vel. Phasellus scelerisque justo arcu, et dignissim ex laoreet non. Aenean sit amet sem sit amet eros aliquam placerat. Maecenas id viverra risus. Mauris tempor dui non commodo ornare. Mauris congue dignissim dolor quis auctor. Quisque eu erat orci. Mauris quis pretium justo, vitae gravida diam.\n\nDonec consequat diam mattis pellentesque tempus. Maecenas et interdum nisl, sit amet molestie felis. Donec euismod rhoncus enim, vel facilisis enim finibus vel. Sed sit amet diam leo. Fusce tincidunt eros quis imperdiet feugiat. Aliquam facilisis tellus fermentum tellus malesuada, ac sagittis metus volutpat. Cras eget interdum lorem. Praesent dignissim tellus eu venenatis sollicitudin. In sed volutpat mauris. Nulla venenatis sed augue sed iaculis.\n\n" ]
                            ]
                        )
                    , Fable.ui "Head"
                        (Panel.default []
                            [ Panel.head [] [ text "In sed volutpat mauris" ]
                            , Panel.content [] [ text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at tortor nec leo vestibulum varius. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Cras elementum odio eu lectus iaculis pretium. Nulla vel velit venenatis, hendrerit nisl sit amet, placerat erat. Duis consectetur ante felis, ac auctor diam maximus vel. Phasellus scelerisque justo arcu, et dignissim ex laoreet non. Aenean sit amet sem sit amet eros aliquam placerat. Maecenas id viverra risus. Mauris tempor dui non commodo ornare. Mauris congue dignissim dolor quis auctor. Quisque eu erat orci. Mauris quis pretium justo, vitae gravida diam.\n\nDonec consequat diam mattis pellentesque tempus. Maecenas et interdum nisl, sit amet molestie felis. Donec euismod rhoncus enim, vel facilisis enim finibus vel. Sed sit amet diam leo. Fusce tincidunt eros quis imperdiet feugiat. Aliquam facilisis tellus fermentum tellus malesuada, ac sagittis metus volutpat. Cras eget interdum lorem. Praesent dignissim tellus eu venenatis sollicitudin. In sed volutpat mauris. Nulla venenatis sed augue sed iaculis.\n\n" ]
                            , Panel.foot []
                                [ Button.multipleRight []
                                    [ Button.default [] [ text "Cancel" ]
                                    , Button.primary [] [ text "Confirm" ]
                                    ]
                                ]
                            ]
                        )
                    ]
                ]
            ]
    in
    Fable.app chapters
