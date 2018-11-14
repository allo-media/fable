module Views.Menu.Primary exposing (view)

import Css as Css exposing (..)
import Css.Animations as CA
import Css.Global exposing (descendants, typeSelector)
import Data.Bookmark exposing (Bookmark(..))
import Data.Chapter as Chapter exposing (Chapter)
import Data.Msg exposing (Msg)
import Data.Story as Story exposing (Story)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Route.Route as Route
import Views.Icon as Icon
import Views.Theme exposing (..)



-- Style


defaultStory : Style
defaultStory =
    Css.batch
        [ Css.property "display" "grid"
        , Css.property "align-content" "center"
        , Css.property "grid-gap" "0.5rem"
        , hover
            [ descendants
                [ typeSelector "svg"
                    [ fill (rgba 255 255 255 0.5)
                    ]
                ]
            , Css.backgroundColor (rgba 255 255 255 0.5)
            , Css.animationName
                (CA.keyframes
                    [ ( 0, [ CA.backgroundColor (rgba 255 255 255 0) ] )
                    , ( 100, [ CA.backgroundColor (rgba 255 255 255 0.5) ] )
                    ]
                )
            , Css.animationDuration (Css.ms 200)
            , Css.animationIterationCount (Css.num 1)
            ]
        , Css.active
            [ backgroundColor (rgba 0 0 0 0.1)
            ]
        , descendants
            [ typeSelector "svg"
                [ fill (rgba 255 255 255 0)
                ]
            ]
        ]


activeStory : Style
activeStory =
    Css.batch
        [ backgroundColor (rgba 0 0 0 0.2)
        , descendants
            [ typeSelector "svg"
                [ fill (rgba 255 255 255 0.8)
                ]
            ]
        , defaultStory
        ]



-- Element


list : Element msg
list =
    styled ul
        [ listStyle none
        , padding zero
        , margin zero
        , fontFamilies [ "Montserrat", .value serif ]
        , fontSize (rem 1)
        , lineHeight (rem 1.5)
        ]


link : Element msg
link =
    styled a
        [ color (rgba 255 255 255 0.6)
        , textDecoration none
        , textTransform capitalize
        , padding4 (px 7) (px 7) (px 7) (Css.rem 3)
        ]



-- Views


chapter : Maybe ( Chapter.Id, Story.Id ) -> Chapter msg -> Html (Msg msg)
chapter active chapter_ =
    li
        [ css
            [ color (rgba 255 255 255 1)
            , position relative
            ]
        ]
        [ title (Chapter.idToString chapter_.id)
        , List.map (story active chapter_) chapter_.stories
            |> list []
        ]


story : Maybe ( Chapter.Id, Story.Id ) -> Chapter msg -> Story msg -> Html (Msg msg)
story active chapter_ story_ =
    li
        [ css
            [ if active == Just ( chapter_.id, story_.id ) then
                activeStory

              else
                defaultStory
            ]
        ]
        [ link [ Route.href (Route.Story chapter_.id story_.id) ] [ text (Story.idToString story_.id) ]
        ]


title : String -> Html (Msg msg)
title string =
    span
        [ css
            [ Css.property "display" "grid"
            , Css.property "grid-template-columns" "auto 1fr"
            , padding4 (px 15) (px 0) (px 10) (px 20)
            , backgroundColor (rgba 255 255 255 0.05)
            , descendants
                [ typeSelector "svg"
                    [ fill (rgba 255 255 255 0.7)
                    , Css.width (Css.rem 1.275)
                    ]
                ]
            ]
        ]
        [ Icon.chapter
        , h2
            [ css
                [ color (rgba 255 255 255 1)
                , fontSize (rem 1.275)
                , fontWeight normal
                , padding zero
                , margin zero
                , textTransform uppercase
                , lineHeight (rem 1.5)
                , letterSpacing (rem 0.05)
                , marginLeft (px 5)
                ]
            ]
            [ text string ]
        ]


view : Maybe ( Chapter.Id, Story.Id ) -> List (Chapter msg) -> Html (Msg msg)
view active chapters =
    div
        [ css [ backgroundColor (rgba 0 0 0 0.2), position relative, Css.height (vh 80) ] ]
        [ List.map (chapter active) chapters
            |> list [ css [ position absolute, top zero, right zero, bottom zero, left zero ] ]
        ]
