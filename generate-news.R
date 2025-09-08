generate_news <- function(input_md, output_qmd = NULL, package = NULL) {
  # Read input markdown file
  lines <- readLines(input_md, warn = FALSE)
  
  # If package is provided, remove it from section titles
  if (!is.null(package)) {
    lines <- gsub(paste0("\\b", package, "\\b"), "", lines)
    # Clean up multiple spaces that may result
    lines <- gsub("  +", " ", lines)
    lines <- trimws(lines)
  }
  
  # Define output file if not provided
  if (is.null(output_qmd)) {
    output_qmd <- sub("\\.md$", ".qmd", input_md)
  }
  
  # Write output file
  writeLines(lines, output_qmd)
  
  message("✅ Converted ", input_md, " → ", output_qmd)
  invisible(output_qmd)
}

generate_news("NEWS.md", package = "GHRexplore")