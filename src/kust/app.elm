module Jannine (..) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Time exposing (fps)
import Window
import Html.Events exposing (on, targetValue)
import String
import Char
import Maybe exposing (..)


type Action
  = Left
  | Right


yogi : String -> Html
yogi input =
  let
    head =
      input |> String.reverse |> String.left 1 |> String.toInt

    -- input |> String.reverse |> String.toList |> List.head
    action =
      case head of
        Ok x ->
          if x % 2 == 0 then
            Left
          else
            Right

        Err msg ->
          Left

    image =
      case action of
        Left ->
          "/out/kust/image/yogi-left.png"

        Right ->
          "/out/kust/image/yogi-right.png"
  in
    img
      [ src image ]
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
    , maxlength 14
    , cols 50
    ]
    []


reverseString : String -> Html
reverseString string =
  div
    []
    [ span
        []
        [ text <| "," ++ (String.reverse string) ]
    ]


view : String -> Html
view string =
  div
    []
    [ yogi string, stringInput, reverseString string ]


size : Signal Int
size =
  fps 30
    |> Signal.foldp (+) 0
    |> Signal.map (\t -> round (200 + 200 * sin (degrees t / 10)))


main : Signal Html
main =
  Signal.map view actions.signal
