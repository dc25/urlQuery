import Html exposing (Html, text, program, button)
import Html.Events exposing (onClick)

type alias Model = Int

type Msg = NoOp

init : (Model, Cmd Msg)
init = (0, Cmd.none)

update : Msg -> Model -> (Model, Cmd Msg)
update c m = (m+1, Cmd.none)

view : Model -> Html Msg
view m = button [onClick NoOp] [text (toString m)]

main : Program Never Model Msg
main =
    program
        { init = init
        , update = update
        , view = view
        , subscriptions = \m -> Sub.none
        }

