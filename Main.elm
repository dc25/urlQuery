import Html exposing (Html, text)
import Navigation 
import UrlParser as Url exposing (parsePath, Parser, stringParam, top, (<?>), map)

type alias Model = 
    { mcode: Maybe {code: Maybe String, location: Navigation.Location} }

type Msg =   UrlChange Navigation.Location

type Route = Code (Maybe String) 
route : Parser (Route -> a) a
route = map Code (top <?> stringParam "code" )

init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    let prout = parsePath route location
    in case prout of
        Just (Code c) -> ({mcode = Just {code=c,location=location}}, Cmd.none)
        _ -> ({mcode=Just {code=Nothing, location=location}}, Cmd.none)

view : Model -> Html Msg
view m = text (toString m) 

update : Msg -> Model -> (Model, Cmd Msg)
update _ model = (model, Cmd.none)

main : Program Never Model Msg
main =
    Navigation.program UrlChange
        { init = init
        , update = update
        , view = view
        , subscriptions = \m -> Sub.none
        }

