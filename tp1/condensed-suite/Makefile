.PRECIOUS: %.mli

all: prog scanner_graph.png

prog:  lexer.cmo prog.cmo
	ocamlc -o $@ $^

scanner_graph.png: scanner_graph.dot
	dot -Tpng scanner_graph.dot > scanner_graph.png

%.cmo: %.ml
	ocamlc -c $<

%.cmi: %.mli
	ocamlc -c $<

%.ml: %.mll 
	ocamllex $<

clean:
	rm -f *.cmi *.cmo
	rm scanner_graph.png
