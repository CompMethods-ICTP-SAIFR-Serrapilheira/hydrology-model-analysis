# Script where .nc4 model outputs are loaded and manipulated to prepare them to the analysis
# adicionar no readme que o historico de manipulacao dos dados crus pode ser visto atraves do header do arquivo netcdf
# ==========================================================

library(ncdf4)
library(reshape)

# ==========================================================
# netCDF files loaded as objects:

# reading .nc4 files
wsoil_ic_spc_nc <- nc_open("data/processed/ic_wsoil_spatial_mean.nc4")
wsoil_pvm_spc_nc <- nc_open("data/processed/pvm_wsoil_spatial_mean.nc4")

# getting the variables from the file
ic_wsoil_spc <- ncvar_get(wsoil_ic_spc_nc, 'mrso')
pvm_wsoil_spc <- ncvar_get(wsoil_pvm_spc_nc, 'mrso')

# ==========================================================

library(ggplot2)
library(zoo)

# ======================================================================
wsoil_df <- cbind.data.frame(ic_wsoil_spc, pvm_wsoil_spc)

scatter_plot <- ggplot(wsoil_df, aes(x = ic_wsoil_spc, y = pvm_wsoil_spc)) +
  geom_point(shape = 1, color = "#282828", alpha = 0.3) +
  geom_smooth(method = lm, show.legend = T, color = "#e29a25") +
  geom_abline(slope = 1, intercept = 0, linetype = 2, color = "#e29a25") +
  scale_x_continuous(limits = c(200,500), breaks = c(200, 300, 400, 500)) +
  scale_y_continuous(limits = c(200,500), breaks = c(200, 300, 400, 500)) +
  labs(x = 'CAETE-IC soil water (mm)', y = 'CAETE-PVM soil water (mm)') +
  theme_bw()

# ======================================================================
ic_wsoil_rmean <- rollmean(ic_wsoil_spc, k = 90, fill = NA)
pvm_wsoil_rmean <- rollmean(pvm_wsoil_spc, k = 90, fill = NA)

wsoil_rmean_df <- cbind.data.frame(ic_wsoil_rmean, pvm_wsoil_rmean)

# Data frame tidying for ggplot legend to work:
wsoil_rmean_df$time <- 1:nrow(wsoil_rmean_df)
wsoil_df_melt <- melt(wsoil_rmean_df, id = "time")

# ======================================================================
# Plotting
line_plot <- ggplot(wsoil_df_melt, aes(x = time, y = value)) +
  geom_line(aes(color = variable)) +
  labs(x = 'Time (days)', y = 'Soil water (mm)', color = 'red') +
  scale_x_continuous(breaks = c(0, 365, 3650, 7300, 10950, 13880)) +
  scale_color_discrete(name = NULL, labels = c("CAETE-IC", "CAETE-PVM")) +
  theme_bw() +
  theme(legend.position = c(0.15,0.07),
        legend.background = element_rect(fill = 'transparent'),
        legend.key = element_rect(fill = 'transparent'))

# ======================================================================

# Saving figs

ggsave(filename = "outputs/figs/wsoil_scat.png", plot = scatter_plot ,units = 'in', width = 5.5, height = 5.5, dpi = 300 )

ggsave(filename = "outputs/figs/wsoil_line.png", plot = line_plot, units = 'in', width = 8.5, height = 4.5, dpi = 300)

# ======================================================================