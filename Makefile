pdf:
	Rscript --quiet _render.R "bookdown::pdf_book"

gitbook:
	Rscript --quiet _render.R "bookdown::gitbook"

all:
	Rscript --quiet _render.R

clean:
	Rscript -e "bookdown::clean_book(TRUE)"
