ASCIIDOCTOR=asciidoctor
STYLESDIR=../../asciidoctor-stylesheet-factory/stylesheets
STYLESHEET=foundation.css

html:
	$(ASCIIDOCTOR) -astylesheet=$(STYLESHEET) -astylesdir=$(STYLESDIR) regal.asciidoc
	$(ASCIIDOCTOR) -astylesheet=$(STYLESHEET) -astylesdir=$(STYLESDIR) api.asciidoc
