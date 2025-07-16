all: Makefile.coq mycompiler
	@+$(MAKE) -f Makefile.coq all

clean: Makefile.coq
	@+$(MAKE) -f Makefile.coq cleanall
	@rm -f Makefile.coq Makefile.coq.conf
	@find . -name *.cmi -delete
	@find . -name *.cmo -delete
	@cd theories/extraction && rm -f *.ml *.mli
	@rm -rf src/extraction
	@rm -f mycompiler

Makefile.coq: _CoqProject
	$(COQBIN)coq_makefile -f _CoqProject -o Makefile.coq

force _CoqProject Makefile: ;

%: Makefile.coq force
	@+$(MAKE) -f Makefile.coq $@

# ===========================================
# Combine extracted code to binary mycompiler
src/extraction: theories/extraction/extraction.vo
	@rm -rf src/extraction
	@cp -r theories/extraction src/extraction

src/extraction/pipeline.cmo : src/extraction
	@cd src/extraction && ocamlc \
		Byte.mli \
		BinNums.mli \
		Datatypes.mli \
		BinPos.mli \
		BinInt.mli \
		bytestring.mli \
		MCString.mli \
		pipeline.mli

	@cd src/extraction && ocamlc -c *.ml

src/utils/caml_bytestring.cmo: src/utils/caml_bytestring.ml src/extraction/pipeline.cmo
	@ocamlc -I src/utils/ -I src/extraction src/utils/caml_byte.mli src/utils/caml_bytestring.mli
	@ocamlc -c -I src/utils/ -I src/extraction src/utils/*.ml

mycompiler: src/utils/caml_bytestring.cmo src/main.ml
	ocamlc -I src/extraction/ -I src/utils \
		src/utils/caml_byte.cmo \
		src/utils/caml_bytestring.cmo \
		src/extraction/BinNums.cmo \
		src/extraction/Datatypes.cmo \
		src/extraction/BinPos.cmo \
		src/extraction/BinInt.cmo \
		src/extraction/bytestring.cmo \
		src/extraction/MCString.cmo \
		src/extraction/pipeline.cmo \
		src/main.ml -o mycompiler

# ===========================================
# Combine extracted code to binary mycompiler

.PHONY: all clean force
