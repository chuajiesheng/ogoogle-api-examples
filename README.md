#ogoogle-api-examples

Examples for [ogoogle-api](https://github.com/chuajiesheng/ogoogle-api) binding library.  
ogoogle-api is a OCaml binding for [google-api-javascript-client](https://developers.google.com/api-client-library/javascript/) 
done via [Js_of_OCaml](http://ocsigen.org/js_of_ocaml) library

##Installation
    make 

##Dependency
1. lwt ( >= 2.4 )
2. deriving-ocsigen
3. ocamlfind
4. ogoogle-api

Best to do the installation via [OPAM](http://opam.ocamlpro.com/index.html) in case you have dependency issues.  
ogoogle-api have to be installed manually via the git repository.

##Usage
Code; Link to ogoogle-api package; Generate .js

    ocamlfind ocamlc -annot -linkpkg -package js_of_ocaml -package js_of_ocaml.syntax -package lwt -package ogoogle-api -syntax camlp4o -o example.ml
    js_of_ocaml example.byte -pretty
    rm example.byte
    
Link to .JS

    <script src="https://apis.google.com/js/client.js"></script>
    <script src="example.js"></script>


##Example
There is an example for every method present in the binding. It is locaated in the `examples` folder.

##Notes
1. As the library currently bind the basic authentication function, API-specific function would still need to be done via `Js.Unsafe.fun_call`
