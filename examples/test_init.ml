let initalized () =
  Firebug.console##log(Js.string "callback~")

let start _ =
  Auth.init (Js.wrap_callback initalized);
  Firebug.console##log(Js.string "init called~");
  Js._true

let _ = Dom_html.window##onload <- Dom_html.handler start
