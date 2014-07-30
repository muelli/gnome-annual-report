.PHONY: report.pdf

FILES_TO_CLEAN = 
FILES_TO_DISTCLEAN = 


report.pdf: 
	latexmk -e '$$pdflatex=q/pdflatex %O -interaction=nonstopmode -shell-escape %S/' -pdf -dvi- -ps- $(@:.pdf=.tex)

FILES_TO_CLEAN += report.run.xml 


%-crop.pdf: %.pdf
	pdfcrop $<   $@


%.pdf: %.eps
	epspdf "$<" "$@"



.PHONY: watch
watch:
	while inotifywait -r -e close_write . ; do $(MAKE) ; done


.PHONY: clean
clean:
	$(if $(FILES_TO_CLEAN),\
		rm -f $(FILES_TO_CLEAN))
	rm -rf pythontex-files-thesis
	latexmk -c thesis

.PHONY: distclean
distclean: clean
	$(if $(FILES_TO_DISTCLEAN),\
		rm -f $(FILES_TO_DISTCLEAN))
	latexmk -C thesis


%.pdf: %.tex
	latexmk -e '$$pdflatex=q/pdflatex %O -interaction=nonstopmode -shell-escape %S/' -pdf -dvi- -ps- $(@:.pdf=.tex)

.DELETE_ON_ERROR:
