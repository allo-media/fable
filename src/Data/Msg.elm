module Data.Msg exposing (Internal(..), Msg(..))

import Browser
import Url exposing (Url)


type Msg msg
    = ExternalMsg msg
    | InternalMsg Internal


type Internal
    = UrlChanged Url
    | UrlRequested Browser.UrlRequest
    | NoOp
