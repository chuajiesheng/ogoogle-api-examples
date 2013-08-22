let client_id = Js.string "111026527826"
let scope_a = [| Js.string "https://www.googleapis.com/auth/plus.me" |]
let scope = Js.array scope_a
let api_key = Js.string "AIzaSyAbB4Mr1ilCJX8MFZKc2qXeY5AIJTXEOo0"
let path = Js.string "/plus/v1/people/me"

let m = Auth.empty_params ()
let _ = m##client_id_ <- client_id
let _ = m##scope_ <- scope

let r = Client.empty_request_args ()
let _ = r##path_ <- path
let _ = r##method_ <- Js.string "GET"
let p = Js.Unsafe.obj [||]
let _ = p##fields <- Js.string "gender"
let _ = r##params_ <- p

let r2 = Client.empty_request_args ()
let _ = r2##path_ <- path
let _ = r2##method_ <- Js.string "GET"
let p2 = Js.Unsafe.obj [||]
let _ = p2##fields <- Js.string "verified"
let _ = r2##params_ <- p

let callback json_resp raw_resp =
  let _ = Firebug.console##log(Js.string "callback~") in
  let _ = Firebug.console##log_2(Js.string "[jsonResp]", json_resp) in
  let _ = Firebug.console##log_2(Js.string "[rawResp]", raw_resp) in
  ()

let opt_params = Client.empty_opt_params ()
let _ = opt_params##callback <- Js.wrap_callback callback

let login_completed (t : Token.oauth_token Js.t) =
  let _ = Firebug.console##log(Js.string "callback~") in
  let _ = Firebug.console##log_2(Js.string "[access token]", t##access_token_) in
  (*
     making a call to Google+ API
     make_api_call function is called once the API interface is loaded
  *)
  let req = Client.request r in
  let req2 = Client.request r2 in
  let batch = Client.new_http_batch () in
  let _ = batch##add (req, opt_params) in
  let _ = batch##add (req2, opt_params) in
  let _ = batch##execute (Js.wrap_callback callback) in
  ()

let start _ =
  let _ = Auth.set_api_key api_key in
  let _ = Firebug.console##log(Js.string "gapi.client.setApiKey called") in
  let _ = Auth.authorize m (Js.wrap_callback login_completed) in
  let _ = Firebug.console##log(Js.string "gapi.auth.authorize called") in
  Js._true

let _ = Dom_html.window##onload <- Dom_html.handler start
