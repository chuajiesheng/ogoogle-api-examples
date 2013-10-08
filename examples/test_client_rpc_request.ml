let client_id = Js.string "111026527826-0de029u61m99jcpcvrfqhakepuhbp5m0"
let api_key = Js.string "J4U3X4-OG82gTOrMr5zPJBb7"

let scope_a = [| Js.string "https://www.googleapis.com/auth/plus.me" |]
let scope = Js.array scope_a

let meth = Js.string "plus.people.get"
let version = Js.string "v1"

let m = Auth.empty_params ()
let _ = m##client_id_ <- client_id
let _ = m##scope_ <- scope

let p = Js.Unsafe.obj [||]
let _ = p##userId <- Js.string "me"

let callback json_resp raw_resp =
  let _ = Firebug.console##log(Js.string "callback~") in
  let _ = Firebug.console##log_2(Js.string "[jsonResp]", json_resp) in
  let _ = Firebug.console##log_2(Js.string "[rawResp]", raw_resp) in
  ()

let login_completed (t : Token.oauth_token Js.t) =
  let _ = Firebug.console##log(Js.string "callback~") in
  let _ = Firebug.console##log_2(Js.string "[access token]", t##access_token_) in
  (*
     making a call to Google+ API
     make_api_call function is called once the API interface is loaded
  *)
  let req = Client.rpc_request meth version p in
  let _ = req##execute(Js.wrap_callback callback) in
  ()

let start _ =
  let _ = Auth.set_api_key api_key in
  let _ = Firebug.console##log(Js.string "gapi.client.setApiKey called") in
  let _ = Auth.authorize m (Js.wrap_callback login_completed) in
  let _ = Firebug.console##log(Js.string "gapi.auth.authorize called") in
  Js._true

let _ = Dom_html.window##onload <- Dom_html.handler start
