(* open Auth_service *)
open Lwt.Infix
open Cohttp




let () = Dream.run
  @@ Dream.logger
  @@ Dream.router [

    Dream.get "/api/wanaka/accounts/login"
    (fun request ->
      let auth = Dream.header request "Authorization" in
      match auth with
        | Some auth -> Auth_service.login auth >>= fun (resp, _body) -> 
            if resp |> Response.status |> Code.code_of_status = 200 then
              Token_service.generate_token () >>= fun (resp, body) ->
                let status = Dream.int_to_status (Response.status resp |> Code.code_of_status) in
                Dream.respond ~status:status ~headers:[("Content-Type", "application/json")] body
            else
              Dream.empty `Unauthorized
        | None -> Dream.empty `Unauthorized);
  ]