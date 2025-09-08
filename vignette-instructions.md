# Vignettes

Run in the R package project:

```r
rmarkdown::render(
  input = "~/Documents/ghrexplore/vignettes/GHRexplore.Rmd",
  output_format = "github_document",
  output_file = "GHRexplore-vignette.md"
)
```
Move the .md file and depending image files to the website repo and link in the index
Copy paste header, badges and hex sticker from main page to the vignette


# Changelog

Run in the R package project: generate-news.R

copy/paste the resulting file in the respective docs folder

Add the link to the reference in the main page

Customize the index page, e.g. add sections and logo



# Reference

Run in the R package project: generate-reference.R

copy/paste the index and function files in the respective docs folder

Add the link to the reference in the main page

Customize the index page, e.g. add sections and logo
