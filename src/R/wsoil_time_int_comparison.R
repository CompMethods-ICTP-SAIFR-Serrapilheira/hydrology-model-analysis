library(dplyr)
library(raster)
library(ggplot2)
library(ggpubr)
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
legend_title <- "Soil water (mm)"
break_scale = c(100, 200, 300, 400, 500, 600)

# CAETE-IC map
ic_plot <- ggplot() +
  geom_raster(data = ic_wsoil_no_na_df, aes(x=x, y=y, fill = soil_water_content.wsoil)) +
  geom_sf(data = world, fill = NA, color = '#282828') +
  coord_sf(xlim = c(-40, -85), ylim = c(-25, 15), expand = FALSE) +
  guides(fill = guide_colorbar(barheight = 25, barwidth = 1.5)) +
  scale_fill_gradient(legend_title, low = '#09b0ea', high = '#011217', limits = c(50,600), breaks = break_scale,labels = break_scale) +
  labs(x = "CAETE-IC") +
  theme_bw() +
  theme(axis.title.y = element_blank())


# CAETE-PVM map
pvm_plot <- ggplot() +
  geom_raster(data = pvm_wsoil_no_na_df, aes(x=x, y=y, fill = soil_water_content.wsoil)) +
  geom_sf(data = world, fill = NA, color = '#282828') +
  coord_sf(xlim = c(-40, -85), ylim = c(-25, 15), expand = FALSE) +
  guides(fill = guide_colorbar(barheight = 25, barwidth = 1.5)) +
  scale_fill_gradient(legend_title, low = '#09b0ea', high = '#011217', limits = c(50,600), breaks = break_scale,labels = break_scale) +
  labs(x = "CAETE-PVM") +
  theme_bw() +
  theme(axis.title.y = element_blank())

# ======================================================

# Saving figure
ggarrange(ic_plot, pvm_plot, ncol = 2, nrow = 1, common.legend = TRUE, legend = 'right') %>%
  ggexport(filename = "outputs/figs/wsoil_time.png", width = 1584, height = 871, dpi = 300)

# ======================================================