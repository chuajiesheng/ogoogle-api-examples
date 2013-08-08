let client_id = Js.string "111026527826"
let immediate = Js._false
let response_type = Js.string "token"
let scope_a = [| Js.string "https://www.googleapis.com/auth/plus.me" |]
let scope = Js.array scope_a

let m = Auth.empty_params ()

let _ = m##client_id_ <- client_id
let _ = m##immediate_ <- immediate
let _ = m##response_type_ <- response_type
let _ = m##scope_ <- scope

let login_completed (t : Token.oauth_token) =
  Dom_html.window##alert(Js.string "hello~");
  ignore(Js._true)

let start _ =
  Auth.authorize m (Js.wrap_callback login_completed);
  Dom_html.window##alert(Js.string "authorize called~");
  Js._true

let _ = Dom_html.window##onload <- Dom_html.handler start
