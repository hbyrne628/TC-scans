#Make sure ggplot2 and tidyverse are installed first

library(tidyverse)

# 1. Load the data
body_data <- read_csv("Specimens_and_Scan_Information_Reformatted.xlsx - Sheet5 (2).csv")

# 2. Rename the columns
clean_body_data <- body_data %>%
  rename(
    Species = `Species name`,
    Avg_Tessera_Width = `Average tesseare width (um)`,
    SD_Tessera_Width = `Standard deviation for tesserae max width (um)`,
    Total_Body_Length = `Total body length (mm)`
  )

# 3. Create the scatter plot with error bars
ggplot(clean_body_data, aes(x = Total_Body_Length, y = Avg_Tessera_Width, color = Species)) +
  
  # Add the error bars first so they sit behind the points
  geom_errorbar(aes(ymin = Avg_Tessera_Width - SD_Tessera_Width, 
                    ymax = Avg_Tessera_Width + SD_Tessera_Width), 
                width = 5,            
  # Altering widtof the horizontal ticks (wider here due to a larger X-axis scale)
                linewidth = 0.6, 
                alpha = 0.7) +
  
  # Add the points
  geom_point(size = 4, alpha = 0.9) +
  
  # Customise the labels and scales
  labs(
    title = "Average Tessera Width vs. Total Body Length",
    subtitle = "Comparing tessera size and variation to overall body size",
    x = "Total Body Length (mm)",
    y = expression("Average Tessera Width (" * mu * "m)"), 
    color = "Shark Species"
  ) +
  
  # Apply a nice theme
  theme_minimal() +
  theme(
    text = element_text(size = 12),
    plot.title = element_text(face = "bold"),
    legend.position = "right"
  )