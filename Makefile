$(info RFC rendering has been tested with mmark version 1.3.4 and xml2rfc 2.5.1, please ensure these are installed and recent enough.)

VERSION := 03
STATUS := draft-
OUTPUT := $(STATUS)lhomme-cellar-matroska-$(VERSION)

all: $(OUTPUT).html $(OUTPUT).txt $(OUTPUT).xml

ebml_matroska_elements4rfc.md: ebml_matroska.xml transforms/ebml_schema2markdown4rfc.xsl
	xsltproc transforms/ebml_schema2markdown4rfc.xsl ebml_matroska.xml > $@

$(OUTPUT).md: rfc_frontmatter.md index.md diagram.md matroska_schema_section_header.md ebml_matroska_elements4rfc.md notes.md order_guidelines.md codec_specs.md chapters.md subtitles.md tagging.md attachments.md cues.md streaming.md menu.md
	cat $^ > $@

%.xml: %.md
	mmark -xml2 -page $< > $@

%.html: %.xml
	xml2rfc --html $< -o $@

%.txt: %.xml
	xml2rfc $< -o $@

ebml_matroska_elements.md: ebml_matroska.xml transforms/ebml_schema2markdown.xsl
	xsltproc transforms/ebml_schema2markdown.xsl $< > $@

website:
	jekyll b

clean:
	$(RM) -f $(OUTPUT).txt $(OUTPUT).html $(OUTPUT).md $(OUTPUT).xml ebml_matroska_elements.md ebml_matroska_elements4rfc.md
	$(RM) -rf _site

