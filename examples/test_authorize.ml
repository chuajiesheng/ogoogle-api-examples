let client_id = Js.string "837050751313"
let immediate = Js._true
let response_type = Js.string "Token"
let scope_a = [| Js.string "https://www.googleapis.com/auth/plus.me" |]
let scope = Js.array scope_a

let m = Auth.empty_params ()

let _ = m##client_id <- client_id
let _ = m##immediate <- Js._true
let _ = m##response_type <- response_type
let _ = m##scope <- scope
