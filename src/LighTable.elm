
module Hello where

import Html exposing (text)

greet: String -> String
greet name = "Hello " ++ name

main: Html.Html
main =
  text (greet "wk")

