
import Graphics.Element exposing (..)
import Mouse
import Time
import Keyboard
import Text
import Window

view: (Int,Int) -> Float -> Element
view (w,h) time =
    time
    |> toString
    |> Text.fromString
    |> Text.height 50
    |> centered
    |> container w h middle

myShow: Int -> Element
myShow a =
    show a

main: Signal Element
main =
    --Signal.map myShow Mouse.position
    --Signal.map myShow (Time.every Time.second)
    --Signal.map myShow Keyboard.presses
    Signal.map2 view Window.dimensions (Time.every Time.second)
