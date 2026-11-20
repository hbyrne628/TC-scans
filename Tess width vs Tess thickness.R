library(tidyverse)

# 1. Load the data
data <- read_csv("Species w_tesserae thickness and av tessera width + SD.csv")

# 2. Clean and rename the columns
clean_data <- data %>%
  rename(Species = `Species name`,Avg_Tessera_Width = `Average tesseare width (um)`, SD_Tessera_Width = `Standard deviation for tesserae max width (um)`, Avg_Layer_Thickness = `Average tesseral layer thickness (um)`)

# 3. Create the scatter plot with error bars
ggplot(clean_data, aes(x = Avg_Layer_Thickness, y = Avg_Tessera_Width, color = Species)) +
  
  # Add error bars first (so they sit behind the points)
  geom_errorbar(aes(ymin = Avg_Tessera_Width - SD_Tessera_Width, ymax = Avg_Tessera_Width + SD_Tessera_Width), width = 1.5, linewidth = 0.6, alpha = 0.7) +
  
  # Add the points mapping shape to Jaw and colour to Species
  geom_point(size = 4, alpha = 0.9) +
  
  # Labels and scales and minimal theme applied
  labs( title = "Average Tessera Width vs. Tesseral Layer Thickness", x = expression("Average Tesseral Layer Thickness (" * mu * "m)"), y = expression("Average Tessera Width (" * mu * "m)"), color = "Shark Species") +  theme_minimal() +  theme(text = element_text(size = 12),plot.title = element_text(face = "bold"), legend.position = "right")