library(tidyverse)

# 1. Load the updated data
data <- read_csv("Species w_body length and av tessera width + SD.csv")

# 2. Clean and rename the columns
clean_data <- data %>%
  rename( Species = `Species name`, Avg_Tessera_Width = `Average tesseare width (um)`, SD_Tessera_Width = `Standard deviation for tesserae max width (um)`, Total_Body_Length = `Total body length (mm)`)

# 3. Create the scatter plot with error bars
ggplot(clean_data, aes(x = Total_Body_Length, y = Avg_Tessera_Width, color = Species)) +
  
  # Add error bars first (so they sit behind the points)
  geom_errorbar(aes(ymin = Avg_Tessera_Width - SD_Tessera_Width, ymax = Avg_Tessera_Width + SD_Tessera_Width), width = 5, linewidth = 0.6, alpha = 0.7) +
  
  # Add the points mapping shape to Jaw and colour to Species
  geom_point(size = 4, alpha = 0.9) +
  
  # Labels and scales and minimal theme applied
  labs(title = "Average Tessera Width vs. Total Body Length", x = "Total Body Length (mm)", y = expression("Average Tessera Width (" * mu * "m)"), color = "Shark Species") + theme_minimal() +  theme( text = element_text(size = 12), plot.title = element_text(face = "bold"), legend.position = "right")