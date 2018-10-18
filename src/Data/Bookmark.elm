module Data.Bookmark exposing (Bookmark(..), title)

import Data.Chapter as Chapter exposing (ChapterId)
import Data.Story as Story exposing (StoryId)
import Data.Ui as Ui exposing (UiId)


type Bookmark
    = ChapterBookmark ChapterId
    | StoryBookmark ChapterId StoryId
    | UiBookmark ChapterId StoryId UiId
    | None


title : Bookmark -> String
title bookmark =
    case bookmark of
        ChapterBookmark chapterId ->
            Chapter.idToString chapterId

        StoryBookmark chapterId storyId ->
            Chapter.idToString chapterId ++ " :: " ++ Story.idToString storyId

        UiBookmark chapterId storyId uiId ->
            String.join " :: " [ Ui.idToString uiId, Story.idToString storyId, Chapter.idToString chapterId ]

        None ->
            ""
