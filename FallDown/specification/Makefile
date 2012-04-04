specification.pdf: specification.ps
	ps2pdf specification.ps

specification.ps: specification.dvi
	dvips -o specification.ps specification.dvi

specification.dvi: specification.tex
	latex specification.tex

clean:
	rm -f specification.{aux,log,dvi,ps,pdf}
