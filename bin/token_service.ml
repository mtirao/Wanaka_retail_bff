open Lwt
open Cohttp
open Cohttp_lwt
open Cohttp_lwt_unix

let generate_token () =
  let headers = Header.init () 
    |> fun h -> Header.add h "x-client-id" "wanaka-budget" 
    |> fun h -> Header.add h "x-client-secret" "ae7a79e3-c2bf-43c3-a339-c27b6ed0cd39"
    |> fun h -> Header.add h "x-grant-type" "api-user" in
    let uri = Uri.of_string "http://localhost:3000/api/wanaka/token" in
      Client.get ~headers uri >>= fun (resp, body) ->
      Body.to_string body >|= fun body_string ->
      (resp, body_string)
