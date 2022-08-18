library(dplyr)
library(raster)
library(ggplot2)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)


# Country limits
world <- ne_countries(scale = "medium", returnclass = "sf")

# CAETE-IC soil water
ic_runoff_map <- raster("data/processed/ic_runoff_time_mean.nc4")
ic_runoff_map_df <- as.data.frame(ic_runoff_map, xy = TRUE)
ic_runoff_no_na_df <- ic_runoff_map_df %>% filter(!is.na(ic_runoff_map_df$total_runoff))

# CAETE-PVM soil water
pvm_runoff_map <- raster("data/processed/pvm_runoff_time_mean.nc4")
pvm_runoff_map_df <- as.data.frame(pvm_runoff_map, xy = TRUE)
pvm_runoff_no_na_df <- pvm_runoff_map_df %>% filter(!is.na(pvm_runoff_map_df$total_runoff)) 

# ======================================================
# CAETE-IC map
ggplot() +
  geom_sf(data = world) +
  coord_sf(xlim = c(-40, -85), ylim = c(-25, 15), expand = FALSE) +
  geom_raster(data = ic_runoff_no_na_df, aes(x=x, y=y, fill = total_runoff)) +
  theme_bw()

# CAETE-PVM map
ggplot() +
  geom_sf(data = world) +
  coord_sf(xlim = c(-40, -85), ylim = c(-25, 15), expand = FALSE) +
  geom_raster(data = pvm_runoff_no_na_df, aes(x=x, y=y, fill = total_runoff)) +
  theme_bw()
# ======================================================
