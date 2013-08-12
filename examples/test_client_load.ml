let client_id = Js.string "111026527826"
let scope_a = [| Js.string "https://www.googleapis.com/auth/plus.me" |]
let scope = Js.array scope_a
let api_key = Js.string "AIzaSyAbB4Mr1ilCJX8MFZKc2qXeY5AIJTXEOo0"

let m = Auth.empty_params ()

let _ = m##client_id_ <- client_id
let _ = m##scope_ <- scope

let process_api_response resp =
  (* the request callback to this function, supplying the resp *)
  Firebug.console##log(Js.string "process api request response");
  Firebug.console##log_2(Js.string "[id]", resp##id);
  Firebug.console##log_2(Js.string "[display name]", resp##displayName);
  ignore(Js._true)

let make_api_call () =
  Firebug.console##log(Js.string "process api callback~");
  (* construct a JavaScript object containing the userId *)
  let o = Js.Unsafe.obj [||] in
  let _ = o##userId <- Js.string "me" in
  (*
     construct a call to the Google+ API
     what you will do here depends on which resource you need from Google
  *)
  let request = Js.Unsafe.fun_call
    (Js.Unsafe.variable "gapi.client.plus.people.get") [|Js.Unsafe.inject o|] in
  (*
     making a call using the constructed request
     process_api_response function is called when the request callback
  *)
  request##execute(Js.wrap_callback process_api_response)

let login_completed (t : Token.oauth_token Js.t) =
  Firebug.console##log(Js.string "callback~");
  Firebug.console##log_2(Js.string "[access token]", t##access_token_);
  (*
     making a call to Google+ API
     make_api_call function is called once the API interface is loaded
  *)
  Client.load
    (Js.string "plus") (Js.string "v1") (Js.wrap_callback make_api_call)

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
