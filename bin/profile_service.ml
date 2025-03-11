open Lwt
open Cohttp
open Cohttp_lwt
open Cohttp_lwt_unix

let get_profile profile =
  let headers = Header.init () 
    |> fun h -> Header.add h "content-type" "Application/json" in
    let uri = Uri.of_string (Printf.sprintf "http://localhost:3002/api/wanaka/profile/%s" profile) in
      Client.get ~headers uri >>= fun (resp, body) ->
      Body.to_string body >|= fun body_string ->
      (resp, body_string)

let delete_profile profile =
  let headers = Header.init () 
    |> fun h -> Header.add h "content-type" "Application/json" in
    let uri = Uri.of_string (Printf.sprintf "http://localhost:3002/api/wanaka/profile/%s" profile) in
      Client.delete ~headers uri >>= fun (resp, body) ->
      Body.to_string body >|= fun body_string ->
      (resp, body_string)