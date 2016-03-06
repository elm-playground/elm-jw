import Graphics.Element exposing (..)
import Text
import Window
import Time
import Keyboard

type Action = Tick | NoOp | Increase | Decrease

view: (Int, Int) -> Int -> Element
view (w, h) time =
    toString time
    |> Text.fromString
    |> Text.height (toFloat w * 0.1)
    |> centered
    |> container w h middle

update: Action -> Int -> Int
update action counter =
    case action of
        Increase -> counter + 1
        Decrease -> max 0 (counter - 1)
        Tick -> max 0 (counter - 1)
        NoOp -> counter

input: Signal Action
input =
    let
        upDown = Signal.map .y Keyboard.arrows
        toAction y =
            if y == 1 then Increase
            else if y == -1 then Decrease
            else NoOp
    in
        Signal.map toAction upDown

time: Signal Action
time =
    Signal.map (always Tick) (Time.every Time.second)

action: Signal Action
action =
    Signal.merge time input

clock: Signal Int
clock =
    Signal.foldp update 24 action

main: Signal Element
main =
    Signal.map2 view Window.dimensions clock