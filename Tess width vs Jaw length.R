library(tidyverse)

# 1. Load the data
data <- read_csv("Species w_jaw length and av tessera width + SD.csv")

# 2. Clean and format the data
clean_data <- data %>%
  # Fill the missing species names downwards for the lower jaws
  fill(Species, .direction = "down") %>%
  # Remove the accidental trailing spaces in the "Jaw" column (e.g., "Upper ")
  mutate(Jaw = str_trim(Jaw)) %>%
  # Rename columns to make them easier to work with in ggplot
  rename(Jaw_Length = `Jaw length (mm)`, Avg_Tessera_Width = `Average tessera width (um)`, SD_Tessera_Width = `Standard deviation for tessera width (um)`)

# 3. Create the scatter plot with error bars
ggplot(clean_data, aes(x = Jaw_Length, y = Avg_Tessera_Width, color = Species, shape = Jaw)) +
  
  # Add error bars first (so they sit behind the points)
  geom_errorbar(aes(ymin = Avg_Tessera_Width - SD_Tessera_Width, ymax = Avg_Tessera_Width + SD_Tessera_Width), width = 0.5, linewidth = 0.6, alpha = 0.7) +
  # Add the points mapping shape to Jaw and color to Species
  geom_point(size = 3.5, alpha = 0.9) +
  
  # Labels and scales and minimal theme applied
  labs( title = "Average Tessera Width vs. Jaw Length",x = "Jaw Length (mm)",
  y = expression("Average Tessera Width (" * mu * "m)"), color = "Shark Species") + theme_minimal() +  theme(text = element_text(size = 12), plot.title = element_text(face = "bold"),legend.position = "right")