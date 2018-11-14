module Main exposing (main)

import Css exposing (..)
import Css.Transitions exposing (easeInOut, transition)
import Fable exposing (Book, app, chapter, story, ui)
import Html.Styled exposing (Html, button, input, text)
import Html.Styled.Attributes exposing (css)


buttonExample : String -> Html Msg
buttonExample string =
    button
        [ css
            [ textAlign center
            , color (hex "FFF")
            , border zero
            , padding2 (px 12) (px 18)
            , fontWeight (int 700)
            , borderRadius (px 3)
            , cursor pointer
            , outline none
            , backgroundColor (rgba 0 0 0 0.5)
            , transition
                [ Css.Transitions.background3 100 0 easeInOut
                ]
            ]
        ]
        [ text string ]


inputExample : String -> Html Msg
inputExample string =
    input
        [ css
            [ borderRadius (px 3)
            , backgroundColor (hex "fff")
            , border3 (px 2) solid (rgba 208 208 208 0.5)
            , padding2 (px 10) (px 13)
            , marginBottom (px 10)
            , outline none
            , color (hex "354052")
            , fontWeight (int 500)
            , display block
            , transition
                [ Css.Transitions.border3 100 0 easeInOut
                ]
            , hover
                [ borderColor (rgba 208 208 208 0.8)
                ]
            , focus
                [ borderColor (rgba 130 97 230 1)
                ]
            ]
        ]
        []


type Msg
    = NoOp


main : Book Msg
main =
    app
        [ chapter "Chapter 1"
            [ story "Story 1"
                [ ui "Ui 1" (buttonExample "Example 1")
                , ui "Ui 2" (inputExample "Example 2")
                ]
            ]
        , chapter
            "Chapter 2"
            [ story "Story 1"
                [ ui "Ui 1" (buttonExample "Example 1")
                ]
            , story "Story 2"
                [ ui "Ui 2" (inputExample "Example 2")
                ]
            ]
        ]
