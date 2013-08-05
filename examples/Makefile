SRC=$(wildcard *.ml)
LIB=-package js_of_ocaml,js_of_ocaml.syntax,lwt,ogoogle-api
SYNTAX=-syntax camlp4o
OCAMLLFLAGS=

all:
	ocamlfind ocamlc -annot -c $(LIB) $(SYNTAX) $(SRC)

clean:
	rm -f *.cm[ioax] *.cmxa *.cmxs *.o *.a *.annot
	rm -f *.type_mli
