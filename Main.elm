import Html exposing (Html, text, program, button, a, div)
import Html.Events exposing (onClick)
import Html.Attributes exposing (href)
import Navigation exposing (..)
import UrlParser as Url exposing (..)

type alias Model = Int

type Msg =   NoOp
           | UrlChange Navigation.Location

clientId = "8256469ec6a458a2b111"
redirectUri = "https://dc25.github.io/oauthElm"
scope = "repo:user"
state = "w9erwlksjdf;kajdsf"

githubOauthUri = "https://github.com/login/oauth/authorize?client_id=" ++ clientId ++ "&redirect_uri=" ++ redirectUri ++ "&scope=" ++ scope ++ "&state=" ++ state

type Route = OauthCode (Maybe String) | OauthState Int
route : Parser (Route -> a) a
route =
  oneOf
    [ map OauthCode (s "blog" <?> stringParam "search")
    , map OauthState (s "blog" </> int)
    ]

initModel : Maybe Route -> ( Model, Cmd Msg )
initModel r = ( 0, Cmd.none )

init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    initModel (Url.parseHash route location)

update : Msg -> Model -> (Model, Cmd Msg)
update c m = (m+1, Cmd.none)

view : Model -> Html Msg
view m = div []
             [ a [href githubOauthUri] [text "github auth"]
             , button [onClick NoOp] [text (toString m)]
             ]

main : Program Never Model Msg
main =
    Navigation.program UrlChange
        { init = init
        , update = update
        , view = view
        , subscriptions = \m -> Sub.none
        }

