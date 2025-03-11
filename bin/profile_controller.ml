open Lwt.Infix
open Cohttp

let get_profile request = Dream.header request "Authorization" in
    match auth with
      | Some auth -> Token_service.validate_token auth >>= fun (resp, _body) -> 
          if resp |> Response.status |> Code.code_of_status = 200 then
            Profile_service.get_profile (Dream.param request "profileId")  >>= fun (resp, body) ->
              let status = Dream.int_to_status (Response.status resp |> Code.code_of_status) in
              Dream.respond ~status:status ~headers:[("Content-Type", "application/json")] body
          else
            Dream.empty `Unauthorized
      | None -> Dream.empty `Unauthorized

let delete_profile request = Dream.header request "Authorization" in
    match auth with
      | Some auth -> Token_service.validate_token auth >>= fun (resp, _body) -> 
          if resp |> Response.status |> Code.code_of_status = 200 then
            Profile_service.delete_profile (Dream.param request "profileId")  >>= fun (resp, body) ->
              let status = Dream.int_to_status (Response.status resp |> Code.code_of_status) in
              Dream.respond ~status:status ~headers:[("Content-Type", "application/json")] body
          else
            Dream.empty `Unauthorized
      | None -> Dream.empty `Unauthorized