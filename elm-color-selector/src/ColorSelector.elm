module ColorSelector exposing (Model, Msg, init, update, view)

import Html exposing (Html, div, text, button)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Http
import Json.Decode exposing (Decoder, list, field, string, int)


-- TYPES

type alias Color =
    { id : Int, name : String, hex : String }

type alias Model =
    { colors : List Color
    , selected : Maybe Int
    , loading : Bool
    , error : Maybe String
    }

type Msg
    = GotColors (Result Http.Error (List Color))
    | SelectColor Int


-- INIT

init : ( Model, Cmd Msg )
init =
    ( { colors = [], selected = Nothing, loading = True, error = Nothing }
    , getColors
    )


-- UPDATE

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotColors (Ok colors) ->
            ( { model | colors = colors, loading = False }, Cmd.none )

        GotColors (Err _) ->
            ( { model | error = Just "Failed to load colors", loading = False }, Cmd.none )

        SelectColor id ->
            ( { model | selected = Just id }, Cmd.none )


-- VIEW

view : Model -> Html Msg
view model =
    div [ style "padding" "20px", style "font-family" "sans-serif" ]
        [ if model.loading then
            text "Loading colors..."

          else if Maybe.withDefault False (Maybe.map (\_ -> True) model.error) then
            text "Error loading colors."

          else
            div []
                [ div [] (List.map (colorButton model.selected) model.colors)
                , case model.selected of
                    Just id ->
                        let
                            selectedColor =
                                List.filter (\c -> c.id == id) model.colors
                                    |> List.head
                        in
                        case selectedColor of
                            Just c -> div [ style "margin-top" "1rem" ] [ text ("Selected: " ++ c.name) ]
                            Nothing -> text ""

                    Nothing ->
                        div [ style "margin-top" "1rem" ] [ text "No color selected" ]
                ]
        ]


colorButton : Maybe Int -> Color -> Html Msg
colorButton selected color =
    let
        border =
            if Just color.id == selected then
                "3px solid black"
            else
                "1px solid #ccc"
    in
    button
        [ onClick (SelectColor color.id)
        , style "background-color" color.hex
        , style "width" "40px"
        , style "height" "40px"
        , style "margin" "5px"
        , style "border" border
        , style "border-radius" "50%"
        ]
        []


-- HTTP

getColors : Cmd Msg
getColors =
    Http.get
        { url = "colors.json"
        , expect = Http.expectJson GotColors colorsDecoder
        }


colorsDecoder : Decoder (List Color)
colorsDecoder =
    list colorDecoder


colorDecoder : Decoder Color
colorDecoder =
    Json.Decode.map3 Color
        (field "id" int)
        (field "name" string)
        (field "hex" string)
