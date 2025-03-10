open Lwt
open Cohttp
open Cohttp_lwt
open Cohttp_lwt_unix

let login auth =
  let headers = Header.init () 
    |> fun h -> Header.add h "Authorization" auth in
    let uri = Uri.of_string "http://localhost:3001/api/wanaka/accounts/login" in
      Client.get ~headers uri >>= fun (resp, body) -> Body.to_string body >|= fun body_string ->
        (resp, body_string)

