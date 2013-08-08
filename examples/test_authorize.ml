let client_id = Js.string "111026527826"
let scope_a = [| Js.string "https://www.googleapis.com/auth/plus.me" |]
let scope = Js.array scope_a
let api_key = Js.string "AIzaSyAbB4Mr1ilCJX8MFZKc2qXeY5AIJTXEOo0"

let m = Auth.empty_params ()

let _ = m##client_id_ <- client_id
let _ = m##scope_ <- scope

let login_completed (t : Token.oauth_token Js.t) =
  Dom_html.window##alert(Js.string "callback~");
  Firebug.console##log_2(Js.string "[access token]", t##access_token_);
  Firebug.console##log_2
    (Js.string "[gapi.auth.getToken()]",
     (Js.Unsafe.fun_call (Js.Unsafe.variable "gapi.auth.getToken") [||]))

let start _ =
  Auth.set_api_key api_key;
  Auth.authorize m (Js.wrap_callback login_completed);
  Dom_html.window##alert(Js.string "authorize called~");
  Js._true

let _ = Dom_html.window##onload <- Dom_html.handler start
