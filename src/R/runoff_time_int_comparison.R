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
ic_runoff_map <- raster("data/processed/ic_runoff_time_mean.nc4")
ic_runoff_map_df <- as.data.frame(ic_runoff_map, xy = TRUE)
ic_runoff_no_na_df <- ic_runoff_map_df %>% filter(!is.na(ic_runoff_map_df$total_runoff))

# CAETE-PVM soil water
pvm_runoff_map <- raster("data/processed/pvm_runoff_time_mean.nc4")
pvm_runoff_map_df <- as.data.frame(pvm_runoff_map, xy = TRUE)
pvm_runoff_no_na_df <- pvm_runoff_map_df %>% filter(!is.na(pvm_runoff_map_df$total_runoff)) 

# ======================================================

legend_title <- "Water runoff (mm)"
break_scale <- c(2, 8, 16, 32, 64 )

# CAETE-IC map
ic_plot <- ggplot() +
  geom_raster(data = ic_runoff_no_na_df, aes(x=x, y=y, fill = total_runoff)) +
  geom_sf(data = world, fill = NA, color = '#282828') +
  coord_sf(xlim = c(-40, -85), ylim = c(-25, 15), expand = FALSE) +
  guides(fill = guide_colorbar(barheight = 25, barwidth = 1.5)) +
  scale_fill_gradient(legend_title, low = '#09b0ea', high = '#011217',trans = 'log', limits = c(0.1,89), breaks = break_scale, labels = break_scale) +
  theme_bw() +
  theme(axis.title = element_blank())

# CAETE-PVM map
pvm_plot <- ggplot() +
  geom_raster(data = pvm_runoff_no_na_df, aes(x=x, y=y, fill = total_runoff)) +
  geom_sf(data = world,  fill = NA, color = '#282828') +
  coord_sf(xlim = c(-40, -85), ylim = c(-25, 15), expand = FALSE) +
  guides(fill = guide_colorbar(barheight = 25, barwidth = 1.5)) +
  scale_fill_gradient(legend_title, low = '#09b0ea', high = '#011217',trans = 'log', limits = c(0.1,89), breaks = break_scale, labels = break_scale) +
  theme_bw() +
  theme(axis.title = element_blank(),)

# ======================================================

# Saving figure
ggarrange(ic_plot, pvm_plot, ncol = 2, nrow = 1, common.legend = TRUE, legend = 'right') %>%
  ggexport(filename = "outputs/figs/runoff_time.png", width = 1584, height = 871)

# ======================================================