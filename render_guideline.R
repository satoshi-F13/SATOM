# Script to render the brand guideline Quarto document

# Install required packages if not already installed
if (!requireNamespace("quarto", quietly = TRUE)) {
  install.packages("quarto")
}
if (!requireNamespace("ggplot2", quietly = TRUE)) {
  install.packages("ggplot2")
}
if (!requireNamespace("grid", quietly = TRUE)) {
  install.packages("grid")
}
if (!requireNamespace("gridExtra", quietly = TRUE)) {
  install.packages("gridExtra")
}
if (!requireNamespace("htmltools", quietly = TRUE)) {
  install.packages("htmltools")
}

# Check if the quarto command-line tool is available
quarto_available <- system("quarto --version", intern = TRUE, ignore.stderr = TRUE)
if (length(quarto_available) == 0) {
  message("Please install Quarto: https://quarto.org/docs/get-started/")
  stop("Quarto command-line tool not found")
}

# Ensure the image files are in the working directory
if (!file.exists("logo1.png") || !file.exists("logo2.png")) {
  message("Warning: logo files not found in working directory")
  message("Make sure to place the SATOM logo files in your working directory")
}

# Render the Quarto document
message("Rendering the brand guideline document...")
system("quarto render brand_guideline.qmd")

message("Done! Brand guideline document has been created.")
message("Open the HTML file in your browser to view it.")