module Jannine (..) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Time exposing (fps)
import Window
import Html.Events exposing (on, targetValue)
import String


yogi =
  img
    [ src "image/yogi.png" ]
    []


actions : Signal.Mailbox String
actions =
  Signal.mailbox ""


stringInput : Html
stringInput =
  input
    [ on "input" targetValue (Signal.message actions.address)
    , rows 1
    , type' "text"
    , cols 50
    ]
    []


reverseString : String -> Html
reverseString string =
  div [] [ text <| ">> " ++ (String.reverse string) ]


view : String -> Html
view string =
  div
    []
    [ yogi, stringInput, reverseString string ]


size : Signal Int
size =
  fps 30
    |> Signal.foldp (+) 0
    |> Signal.map (\t -> round (200 + 200 * sin (degrees t / 10)))


main : Signal Html
main =
  Signal.map view actions.signal
