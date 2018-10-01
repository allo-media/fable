module Data.Bookmark exposing (Bookmark(..), title)

import Data.Chapter exposing (ChapterId, chapterIdToString)
import Data.Story exposing (StoryId, storyIdToString)
import Data.Ui exposing (UiId, uiIdToString)


type Bookmark
    = ChapterBookmark ChapterId
    | StoryBookmark ChapterId StoryId
    | UiBookmark ChapterId StoryId UiId
    | None


title : Bookmark -> String
title bookmark =
    case bookmark of
        ChapterBookmark chapterId ->
            chapterIdToString chapterId

        StoryBookmark chapterId storyId ->
            chapterIdToString chapterId ++ " :: " ++ storyIdToString storyId

        UiBookmark chapterId storyId uiId ->
            uiIdToString uiId
                |> (++) " :: "
                |> (++) (storyIdToString storyId)
                |> (++) " :: "
                |> (++) (chapterIdToString chapterId)

        None ->
            ""
