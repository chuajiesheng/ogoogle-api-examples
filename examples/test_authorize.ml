let client_id = Js.string "111026527826-0de029u61m99jcpcvrfqhakepuhbp5m0"
let api_key = Js.string "J4U3X4-OG82gTOrMr5zPJBb7"
let scope_a = [| Js.string "https://www.googleapis.com/auth/plus.me" |]
let scope = Js.array scope_a

let m = Auth.empty_params ()

let _ = m##client_id_ <- client_id
let _ = m##scope_ <- scope

let login_completed (t : Token.oauth_token Js.t) =
  Firebug.console##log(Js.string "callback~");
  Firebug.console##log_2(Js.string "[access token]", t##access_token_);
  Firebug.console##log_2
    (Js.string "[gapi.auth.getToken()]",
     (Js.Unsafe.fun_call (Js.Unsafe.variable "gapi.auth.getToken") [||]))

let initalized () =
  Auth.set_api_key api_key;
  Firebug.console##log(Js.string "gapi.client.setApiKey called");
  Auth.authorize m (Js.wrap_callback login_completed);
  Firebug.console##log(Js.string "gapi.auth.authorize called");
  ()

let start _ =
  Auth.init (Js.wrap_callback initalized);
  Firebug.console##log(Js.string "gapi.auth.init called");
  Js._true

let _ = Dom_html.window##onload <- Dom_html.handler start
