module Views.Icon exposing (chapter, fable)

import Css exposing (..)
import Svg.Styled as S exposing (..)
import Svg.Styled.Attributes as SA exposing (..)


chapter : Svg msg
chapter =
    svg
        [ css
            [ Css.width (Css.rem 1.5)
            , Css.fill (rgba 255 255 255 0.35)
            ]
        , SA.viewBox "0 0 16 20"
        ]
        [ S.path [ d "M13 0H3c-.55 0-1 .45-1 1v14c0 .55.318.682.707.293l4.586-4.586c.389-.389 1.025-.389 1.414 0l4.586 4.586c.389.389.707.257.707-.293V1c0-.55-.45-1-1-1z" ] []
        ]


fable : Svg msg
fable =
    svg
        [ css
            [ Css.fill (rgba 255 255 255 0.7)
            , Css.width (Css.rem 5)
            ]
        , SA.viewBox "0 0 58.12 78.75"
        ]
        [ g []
            [ S.path [ d "M53.44 0h-45A8.45 8.45 0 0 0 0 8.44v61.87a8.45 8.45 0 0 0 8.4 8.44h45.07a4.69 4.69 0 0 0 4.65-4.69V4.69A4.68 4.68 0 0 0 53.44 0zM1.88 8.44A6.55 6.55 0 0 1 7.5 2v60a8.37 8.37 0 0 0-5.62 3.11zm54.37 65.62a2.82 2.82 0 0 1-2.81 2.82h-45a6.57 6.57 0 0 1 0-13.13h45a4.63 4.63 0 0 0 2.77-1zm0-15a2.81 2.81 0 0 1-2.81 2.81H9.38v-60h44.06a2.83 2.83 0 0 1 2.81 2.82z" ] []
            , S.path [ d "M52.5 70.31a.94.94 0 0 0-.94-.94h-3.75a.94.94 0 1 0 0 1.88h3.75a.94.94 0 0 0 .94-.94zM45 70.31a.94.94 0 0 0-.94-.94h-1.87a.94.94 0 0 0 0 1.88h1.87a.94.94 0 0 0 .94-.94zM39.38 70.31a.94.94 0 0 0-.94-.94h-3.75a.94.94 0 0 0 0 1.88h3.75a.94.94 0 0 0 .94-.94zM31.88 70.31a.94.94 0 0 0-.94-.94h-7.5a.94.94 0 0 0 0 1.88h7.5a.94.94 0 0 0 .94-.94zM20.63 70.31a.94.94 0 0 0-.94-.94h-15a.94.94 0 0 0 0 1.88h15a.94.94 0 0 0 .94-.94zM49.69 65.62a.94.94 0 0 0 0 1.88h3.75a.94.94 0 0 0 0-1.88zM44.06 67.5h1.88a.94.94 0 0 0 0-1.88h-1.88a.94.94 0 1 0 0 1.88zM36.56 67.5h3.75a.94.94 0 0 0 0-1.88h-3.75a.94.94 0 1 0 0 1.88zM25.31 67.5h7.5a.94.94 0 0 0 0-1.88h-7.5a.94.94 0 0 0 0 1.88zM6.56 67.5h15a.94.94 0 1 0 0-1.88h-15a.94.94 0 0 0 0 1.88zM53.44 73.12h-3.75a.94.94 0 0 0 0 1.88h3.75a.94.94 0 0 0 0-1.88zM45.94 73.12h-1.88a.94.94 0 1 0 0 1.88h1.88a.94.94 0 0 0 0-1.88zM40.31 73.12h-3.75a.94.94 0 1 0 0 1.88h3.75a.94.94 0 0 0 0-1.88zM32.81 73.12h-7.5a.94.94 0 0 0 0 1.88h7.5a.94.94 0 0 0 0-1.88zM21.56 73.12h-15a.94.94 0 0 0 0 1.88h15a.94.94 0 1 0 0-1.88zM18.27 9.91v10.48a.89.89 0 0 1-.12.54.51.51 0 0 1-.21.19c-.07 0-.1.08-.08.13a.08.08 0 0 0 .08.06 1.61 1.61 0 0 1 .47.13 2.82 2.82 0 0 1 .8.6 2.49 2.49 0 0 0 1 .63 2.87 2.87 0 0 0 .84.15c.1 0 .16 0 .16-.12s-.06-.12-.17-.16a2.59 2.59 0 0 1-.33-.17 1.19 1.19 0 0 1-.41-.45 2.64 2.64 0 0 1-.23-.61 3 3 0 0 1-.1-.65v-3.54a1.89 1.89 0 0 1 .35-1.24 1.37 1.37 0 0 1 .76-.51.79.79 0 0 1 .69.14.68.68 0 0 1 .15.75.12.12 0 0 0 0 .14.34.34 0 0 0 .14 0 1.26 1.26 0 0 0 .55-.59 1.37 1.37 0 0 0 .1-.79 1.17 1.17 0 0 0-.38-.68 1.35 1.35 0 0 0-.93-.29 1.62 1.62 0 0 0-.7.13 1.56 1.56 0 0 0-.46.28 1.16 1.16 0 0 0-.31.39v-4.36c.18.1.37.19.57.28a5.05 5.05 0 0 0 .66.25 7.35 7.35 0 0 0 .8.18 6.38 6.38 0 0 0 1 .07 2.2 2.2 0 0 0 1.28-.35 2.27 2.27 0 0 0 .73-.83 1.79 1.79 0 0 0 .21-.94.93.93 0 0 0-.28-.7.14.14 0 0 0-.15 0 .17.17 0 0 0-.11.11 1.2 1.2 0 0 1-.15.37 2 2 0 0 1-.32.4 1.77 1.77 0 0 1-.47.32 1.42 1.42 0 0 1-.63.13 6.38 6.38 0 0 1-1-.08 4.79 4.79 0 0 1-.83-.21l-.74-.27-.77-.27a9.45 9.45 0 0 0-.91-.21 8.11 8.11 0 0 0-1.18-.08 4.42 4.42 0 0 0-1.71.29 2.88 2.88 0 0 0-1 .7 1.89 1.89 0 0 0-.47.92 2 2 0 0 0 0 .92 1.4 1.4 0 0 0 .4.7 1 1 0 0 0 .7.29c.08 0 .14 0 .16-.06s.07-.11 0-.16a1.1 1.1 0 0 1-.26-.61 1.34 1.34 0 0 1 .12-.78 1.62 1.62 0 0 1 .65-.68 2.5 2.5 0 0 1 1.33-.29 5.33 5.33 0 0 1 .71.01z" ] []
            , S.path [ d "M24.64 12.75a.07.07 0 0 0-.06.06s0 .08.06.13l.16.14c.06.05.08.14.05.28l-2 5.63a1.79 1.79 0 0 1-.23.48 1.33 1.33 0 0 1-.23.27 1.05 1.05 0 0 1-.2.14l-.13.07C22 20 22 20 22 20.07a.08.08 0 0 0 .07.05H24s.05 0 .06-.06A.1.1 0 0 0 24 20l-.09-.07a.61.61 0 0 1-.12-.15.82.82 0 0 1-.07-.25.85.85 0 0 1 0-.37l.45-1.25 2.27.74.09.37a1.32 1.32 0 0 1 .06.39 1 1 0 0 1 0 .35.49.49 0 0 1-.21.24c-.06 0-.08.05-.07.1s0 .07.07.07h2.52s.05 0 .07-.05S29 20 28.9 20l-.1-.07a.94.94 0 0 1-.16-.14 2 2 0 0 1-.19-.27 3 3 0 0 1-.2-.48l-1.46-5.56c-.05-.15-.06-.26 0-.31a1.15 1.15 0 0 1 .16-.18c.06 0 .09-.09.08-.13a.08.08 0 0 0-.08-.06h-2.31zm1.55 4.77L24.5 17l.88-2.53zM29.56 19.75a1 1 0 0 1-.22.2c-.07 0-.09.07-.07.12s0 .07.07.07H33a2.5 2.5 0 0 0 1.28-.3 2.08 2.08 0 0 0 .72-.74 2 2 0 0 0 .27-1 2.08 2.08 0 0 0-.17-1 1.77 1.77 0 0 0-.61-.75 1.67 1.67 0 0 0-1-.29 1.17 1.17 0 0 0 .68-.32 1.6 1.6 0 0 0 .44-.64 2 2 0 0 0 .12-.8 1.55 1.55 0 0 0-.24-.78 1.62 1.62 0 0 0-.66-.6 2.4 2.4 0 0 0-1.15-.24h-3.3a.12.12 0 0 0-.11.05s0 .07.07.13l.21.16a.42.42 0 0 1 .12.33v5.85a1 1 0 0 1-.11.55zm1.79-6.18h.9a.73.73 0 0 1 .62.35 1.45 1.45 0 0 1 .19.73 1.29 1.29 0 0 1-.24.71.71.71 0 0 1-.64.33h-.83zm0 3.09h1.13a1 1 0 0 1 .62.23 1.26 1.26 0 0 1 .35.53 1.66 1.66 0 0 1 .11.67 1.67 1.67 0 0 1-.14.67 1.27 1.27 0 0 1-.4.51 1 1 0 0 1-.64.2h-1zM40.06 20.14a.87.87 0 0 0 .6-.22 1.43 1.43 0 0 0 .38-.54 2.1 2.1 0 0 0 .16-.71 1.83 1.83 0 0 0-.1-.71 1.18 1.18 0 0 0-.39-.54 1 1 0 0 0-.71-.22.88.88 0 0 0-.7.24 1 1 0 0 0-.24.51.41.41 0 0 0 .2.41.36.36 0 0 0 .41 0h.19s.07.05.1.1a.56.56 0 0 1 0 .26.68.68 0 0 1-.14.39 1 1 0 0 1-.36.28 1.92 1.92 0 0 1-.71.11h-1v-6a.38.38 0 0 1 .25-.4l.21-.16a.13.13 0 0 0 0-.13v-.06h-2.35l-.07.06c-.07.06 0 .08.07.13l.21.16a.42.42 0 0 1 .12.33v5.77a1 1 0 0 1-.11.55 1 1 0 0 1-.22.2c-.07 0-.09.07-.07.12s0 .07.07.07zM47.25 18.6h-.49a.42.42 0 0 0-.31.11l-.37.39a1.08 1.08 0 0 1-.4.28 1.27 1.27 0 0 1-.47.09h-.67a.65.65 0 0 1-.68-.47 1.63 1.63 0 0 1-.09-.45v-.45a1.68 1.68 0 0 1 .31-1.1 1.23 1.23 0 0 1 .66-.45.66.66 0 0 1 .61.13.6.6 0 0 1 .14.67.13.13 0 0 0 0 .1.1.1 0 0 0 .12 0 1 1 0 0 0 .49-.52 1.17 1.17 0 0 0 .09-.68 1 1 0 0 0-.34-.6 1.14 1.14 0 0 0-.82-.26 1.56 1.56 0 0 0-.62.11 2 2 0 0 0-.39.25 1.35 1.35 0 0 0-.29.35v-2.54h1.3a1.49 1.49 0 0 1 .47.07.86.86 0 0 1 .39.23l.24.25.15.16a.38.38 0 0 0 .13.08h.66a.23.23 0 0 0 .22-.11.24.24 0 0 0 0-.26l-.51-1a.51.51 0 0 0-.46-.26h-4.58s-.05 0-.06.06 0 .08.06.13l.21.16a.42.42 0 0 1 .13.33v5.8a.91.91 0 0 1-.12.55 1 1 0 0 1-.22.2c-.07 0-.09.07-.07.12s0 .07.07.07h4.78a.46.46 0 0 0 .45-.28l.5-.88c.05-.11.06-.2 0-.27a.25.25 0 0 0-.22-.11zM46.85 22.25h-.08l-.18.05a1.41 1.41 0 0 0-.32.09l-.43.1c-.33.06-.74.14-1.21.2s-1 .11-1.56.13-1.21 0-1.88 0-1.39-.11-2.11-.22c-1.44-.19-3-.5-4.5-.83s-3.12-.65-4.6-.88a23.38 23.38 0 0 0-4.22-.29 16.81 16.81 0 0 0-1.72.13c-.52.08-.95.16-1.31.24l-.47.11-.36.1a.82.82 0 0 1-.2.06h-.07a.33.33 0 0 0-.14.1s0 .1-.06.16a.73.73 0 0 0 0 .36c.06.2.27.46.42.41H22.06l.28-.09.41-.14a9.29 9.29 0 0 1 1.14-.24 12 12 0 0 1 1.53-.19 22 22 0 0 1 4 .13c1.45.17 3 .47 4.58.76s3.14.59 4.64.78a25.59 25.59 0 0 0 4.24.21 16.25 16.25 0 0 0 1.69-.14l.36-.06.33-.05.59-.13h.24l.22-.06.34-.1.28-.07c.16-.06.3-.15.27-.34s-.2-.35-.35-.29zM44.57 28H19.18a2.53 2.53 0 0 0-2.53 2.53v16.59a2.54 2.54 0 0 0 2.53 2.54h8.18l-1.55 3.42a1.14 1.14 0 0 0 .08 1.09 1.13 1.13 0 0 0 1 .52h10a1.15 1.15 0 0 0 1.15-1.14 1.19 1.19 0 0 0-.13-.53l-1.53-3.36h8.18a2.54 2.54 0 0 0 2.54-2.54V30.57A2.54 2.54 0 0 0 44.57 28zm0 19.33H19.18a.25.25 0 0 1-.25-.25V30.57a.25.25 0 0 1 .25-.25h25.39a.25.25 0 0 1 .25.25v16.55a.25.25 0 0 1-.25.25z" ] []
            , S.path [ d "M35.39 33.48a.22.22 0 0 0-.31 0l-1.24 1.24a.23.23 0 0 0 0 .32l1.76 1.76a.17.17 0 0 0 .15 0 .25.25 0 0 0 .17-.08l1.24-1.24a.22.22 0 0 0 0-.31zM27.79 41.18a.2.2 0 0 0-.21 0 .26.26 0 0 0-.17.17l-.85 2.51a.2.2 0 0 0 0 .21.17.17 0 0 0 .15 0h.06l2.51-.84a.3.3 0 0 0 .17-.18.2.2 0 0 0 0-.21zM34.12 40a.4.4 0 0 0 .22-.27.36.36 0 0 0-.08-.33l-.46-.53 1.38-1.38a.3.3 0 0 0 .08-.16.23.23 0 0 0 0-.15l-1.76-1.76a.23.23 0 0 0-.32 0l-1.34 1.34a25.51 25.51 0 0 0-2.61-2.18A5.39 5.39 0 0 0 27 33.52a.39.39 0 0 0-.27.11.36.36 0 0 0-.12.28 4.66 4.66 0 0 0 1 2 25.62 25.62 0 0 0 2.32 2.78l-1.75 1.75a.23.23 0 0 0 0 .32l1.76 1.76a.17.17 0 0 0 .15 0 .25.25 0 0 0 .17-.08L32 40.69l.47.4a.38.38 0 0 0 .25.09h.06A.4.4 0 0 0 33 41a2.58 2.58 0 0 1 .4-.5 2.35 2.35 0 0 1 .72-.5zM35.1 40.34a1.75 1.75 0 0 0-1.25.55 1.52 1.52 0 0 0-.55 1.33 1.49 1.49 0 0 0 .93 1.05 4.19 4.19 0 0 0 1.2.33 2.4 2.4 0 0 1 1 .33.39.39 0 0 0 .21.06.41.41 0 0 0 .16 0 .39.39 0 0 0 .23-.3 3.42 3.42 0 0 0-.55-2.55 1.81 1.81 0 0 0-1.38-.8z" ] []
            ]
        ]