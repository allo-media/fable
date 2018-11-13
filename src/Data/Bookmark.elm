module Data.Bookmark exposing (Bookmark(..), title)

import Data.Chapter as Chapter
import Data.Story as Story
import Data.Ui as Ui


type Bookmark
    = ChapterBookmark Chapter.Id
    | StoryBookmark Chapter.Id Story.Id
    | UiBookmark Chapter.Id Story.Id Ui.Id
    | None


title : Bookmark -> String
title bookmark =
    case bookmark of
        ChapterBookmark chapterId ->
            Chapter.idToString chapterId

        StoryBookmark chapterId storyId ->
            Chapter.idToString chapterId ++ " :: " ++ Story.idToString storyId

        UiBookmark chapterId storyId uiId ->
            String.join " :: " [ Chapter.idToString chapterId, Story.idToString storyId, Ui.idToString uiId ]

        None ->
            ""
