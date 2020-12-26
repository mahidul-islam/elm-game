module Main exposing (main)
import Playground exposing (..)
import Html exposing (col)

constants : { gameWidth : Number}
constants = { gameWidth = 12}

main = game view update (0,0)


type alias Model = (Float, Float)


--UPDATE
update : Computer -> Model -> Model
update computer (x,y) =
    ( x + 1 * toX computer.keyboard
    , y + 1 * toY computer.keyboard


        )

-- VIEW
view : Computer -> Model -> List Shape
view computer model =
    [
        group
            (viewGame computer model)
            |> scale (computer.screen.width / constants.gameWidth)
    ]

viewGame : Computer -> Model -> List Shape
viewGame computer (x,y) =
    -- [ circle blue 1
    --     |> move x y
    -- ]
    gridDots

gridDots: List Shape
gridDots =
    let
        dot (i, j) =
            group
                [circle blue 0.05
                -- , words black (String.fromInt i ++ "," ++ String.fromInt j)
                --     |> scale 0.02
                --     |> moveY 0.25
                ]
                |> move (toFloat i) (toFloat j)
    in
        curtesianProduct
            (List.range -5 5)
            (List.range -5 5)
                |> List.map dot

curtesianProduct: List a -> List b -> List (a, b)
curtesianProduct list1 list2 =
    let
        column j =
            list1 |> List.map(\i -> (i, j))
    in
        list2 |> List.concatMap column