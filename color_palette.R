# Script to generate a standalone SATOM color palette visualization

# Load required libraries
library(ggplot2)

# Define the SATOM color palette
satom_colors <- c(
  "awanokuni" = "#E3EBF3",
  "samue" = "#7093BF",
  "noren" = "#375A9D",
  "hakujiiro" = "#E9EAEB",
  "ginhakushoku" = "#D3D3D2",
  "gosuiro" = "#323172",
  "sitagoshirae" = "#E7D3CF",
  "gochiso" = "#CB6874",
  "hashi" = "#a47d59",
  "urahairo" = "#97CEA1"
)

# Create a data frame for ggplot2
colors_df <- data.frame(
  name = names(satom_colors),
  hex = unname(satom_colors),
  row = c(1,1,1,1,1, 2,2,2,2,2),  # First row, then second row
  col = c(1,2,3,4,5, 1,2,3,4,5),  # Columns 1-5
  stringsAsFactors = FALSE
)

# Create the color palette visualization
color_palette <- ggplot(colors_df, aes(x = col, y = -row)) + 
  # Add circles for the colors
  geom_point(aes(color = name), size = 24) + 
  # Add text for the color names
  geom_text(aes(label = name), 
            vjust = 2.7, 
            size = 4, 
            fontface = "bold") +
  # Add text for the hex codes
  geom_text(aes(label = hex), 
            vjust = 3.8, 
            size = 3.5) +
  # Set the colors to use the actual hex values
  scale_color_manual(values = setNames(colors_df$hex, colors_df$name)) +
  # Remove all unnecessary elements
  theme_void() + 
  # Remove the legend
  theme(legend.position = "none") +
  # Add title
  ggtitle("SATOM Color Palette") +
  theme(plot.title = element_text(hjust = 0.5, size = 18, face = "bold", margin = margin(b = 20))) +
  # Set appropriate x and y limits
  xlim(0.5, 5.5) +
  ylim(-2.5, -0.5)

# Save to PDF
ggsave("SATOM_Color_Palette.pdf", color_palette, width = 10, height = 6, units = "in")

# Save to PNG
ggsave("SATOM_Color_Palette.png", color_palette, width = 10, height = 6, units = "in", dpi = 150)

# Create a second version with pure circles
create_circle_palette <- function() {
  # Set up plotting area
  png("SATOM_Color_Circles.png", width = 800, height = 500, res = 100)
  par(mar = c(2, 1, 3, 1), mfrow = c(2, 5))
  
  # Loop through the colors
  for (i in seq_along(satom_colors)) {
    name <- names(satom_colors)[i]
    hex <- satom_colors[i]
    
    # Create empty plot
    plot(0, 0, type = "n", xlim = c(0, 1), ylim = c(0, 1), 
         axes = FALSE, xlab = "", ylab = "")
    
    # Draw circle
    symbols(0.5, 0.6, circles = 0.3, inches = FALSE, add = TRUE, 
            bg = hex, fg = "gray80")
    
    # Add text
    text(0.5, 0.25, name, cex = 1.2, font = 2)
    text(0.5, 0.15, hex, cex = 1)
  }
  
  # Add title
  mtext("SATOM Color Palette", side = 3, line = 1, outer = TRUE, cex = 1.5, font = 2)
  
  dev.off()
}

create_circle_palette()

print("Color palette files created: SATOM_Color_Palette.pdf, SATOM_Color_Palette.png, and SATOM_Color_Circles.png")