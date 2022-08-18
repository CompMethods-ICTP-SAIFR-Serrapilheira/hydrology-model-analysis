library(dplyr)
library(raster)
library(ggplot2)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)


# Country limits
world <- ne_countries(scale = "medium", returnclass = "sf")

# CAETE-IC soil water
ic_wsoil_map <- raster("data/processed/ic_wsoil_time_mean.nc4")
ic_wsoil_map_df <- as.data.frame(ic_wsoil_map, xy = TRUE)
ic_wsoil_no_na_df <- ic_wsoil_map_df %>% filter(!is.na(ic_wsoil_map_df$soil_water_content.wsoil))

# CAETE-PVM soil water
pvm_wsoil_map <- raster("data/processed/pvm_wsoil_time_mean.nc4")
pvm_wsoil_map_df <- as.data.frame(pvm_wsoil_map, xy = TRUE)
pvm_wsoil_no_na_df <- pvm_wsoil_map_df %>% filter(!is.na(pvm_wsoil_map_df$soil_water_content.wsoil)) 

# ======================================================
# CAETE-IC map
ggplot() +
  geom_sf(data = world) +
  coord_sf(xlim = c(-40, -85), ylim = c(-25, 15), expand = FALSE) +
  geom_raster(data = ic_wsoil_no_na_df, aes(x=x, y=y, fill = soil_water_content.wsoil)) +
  theme_bw()

# CAETE-PVM map
ggplot() +
  geom_sf(data = world) +
  coord_sf(xlim = c(-40, -85), ylim = c(-25, 15), expand = FALSE) +
  geom_raster(data = pvm_wsoil_no_na_df, aes(x=x, y=y, fill = soil_water_content.wsoil)) +
  theme_bw()
# ======================================================
