library(rd2markdown)

# -------- SETTINGS --------
pkg <- "GHRexplore"            # Your package name here
base_dir <- "docs/reference" # Base folder where everything will go

# Define paths
functions_dir <- file.path(base_dir, paste0(pkg, "-reference"))   # e.g., docs/reference/GHRtools-reference
index_file <- file.path(base_dir, paste0(pkg, "-index.qmd"))      # e.g., docs/reference/GHRtools-index.qmd

# Create directory for function files if it doesn't exist
dir.create(functions_dir, recursive = TRUE, showWarnings = FALSE)

# Helper to clean function name: remove trailing ".Rd" if present
clean_fn_name <- function(fn) {
  sub("\\.Rd$", "", fn)
}

# Helper to extract title text from Rd (to use as individual page title)
get_rd_title <- function(rd) {
  title_tag <- rd[sapply(rd, function(x) attr(x, "Rd_tag")) == "\\title"]
  if (length(title_tag) == 0) return("No title available.")
  # Collapse all text inside title tag
  paste(sapply(title_tag[[1]], function(x) if(is.character(x)) x else paste(unlist(x), collapse = " ")), collapse = " ")
}

# Prepare list for index links
fn_links <- c()

# Convert each Rd file to a .qmd
for (fn in names(rd_files)) {
  rd <- rd_files[[fn]]
  md <- rd2markdown::rd2markdown(rd)

  # Clean function name for display (remove ".Rd")
  clean_name <- clean_fn_name(fn)

  # Extract the actual title from Rd for the individual page
  page_title <- get_rd_title(rd)

  # Create the individual function page with the Rd markdown content
  qmd_content <- paste0(
    "---\n",
    "format: html\n",
    "toc: true\n",
    "---\n\n",
    md
  )

  qmd_path <- file.path(functions_dir, paste0(fn, ".qmd"))
  writeLines(qmd_content, qmd_path)

  # Prepare the description snippet for index page
  desc_snippet <- get_first_sentence_desc(rd)

  # Relative path for index links
  rel_path <- file.path(paste0(pkg, "-reference"), paste0(fn, ".qmd"))

  # Compose a bullet point with function name and description
  fn_links <- c(fn_links, paste0("- [`", clean_name, "()`](", rel_path, "): ", desc_snippet, "\n"))
}

# Create the index .qmd file with extra spacing between items (adding an empty line between bullets)
index_content <- paste(
  "---",
  paste0("title: \"", pkg, " Reference\""),
  "format: html",
  "toc: false",
  "---",
  "",
  paste0("Function reference for the **", pkg, "** package:"),
  "",
  paste(fn_links, collapse = "\n"),
  sep = "\n"
)

writeLines(index_content, index_file)