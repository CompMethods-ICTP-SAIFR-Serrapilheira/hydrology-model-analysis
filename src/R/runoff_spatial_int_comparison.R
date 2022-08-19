# ==========================================================

library(ncdf4)
library(ggplot2)
library(zoo)
library(reshape)

# ==========================================================
# netCDF files loaded as objects:

# reading .nc4 files
runoff_ic_spc_nc <- nc_open("data/processed/ic_runoff_spatial_mean.nc4")
runoff_pvm_spc_nc <- nc_open("data/processed/pvm_runoff_spatial_mean.nc4")

# getting the variables from the file
ic_runoff_spc <- ncvar_get(runoff_ic_spc_nc, 'mrro')
pvm_runoff_spc <- ncvar_get(runoff_pvm_spc_nc, 'mrro')

# ==========================================================

runoff_df <- cbind.data.frame(ic_runoff_spc, pvm_runoff_spc)

scatter_plot <- ggplot(runoff_df, aes(x = ic_runoff_spc, y = pvm_runoff_spc)) +
  geom_point(shape = 1, color = "#282828", alpha = 0.3) +
  geom_smooth(method = lm, show.legend = T, color = "#e29a25") +
  geom_abline(slope = 1, intercept = 0, linetype = 2, color = '#e29a25') +
  scale_x_log10(limits = c(1,50)) +
  scale_y_log10(limits = c(1,50)) +
  labs(x = "CAETE-IC runoff (mm)", y = "CAETE-PVM runoff (mm)") +
  theme_bw()
  
ic_runoff_rmean <- rollmean(ic_runoff_spc, k = 90, fill = NA)
pvm_runoff_rmean <- rollmean(pvm_runoff_spc, k = 90, fill = NA)

runoff_rmean_df <- cbind.data.frame(ic_runoff_rmean, pvm_runoff_rmean)


# Data frame tidying for ggplot legend to work:
runoff_rmean_df$time <- 1:nrow(runoff_rmean_df)
runoff_df_melt <- melt(runoff_rmean_df, id = "time")

# ======================================================================
# Plotting
line_plot <- ggplot(runoff_df_melt, aes(x = time, y = value)) +
  geom_line(aes(color = variable)) +
  labs(x = 'Time (days)', y = 'Water runoff (mm)', color = 'red') +
  scale_x_continuous(breaks = c(0, 365, 3650, 7300, 10950, 13880)) +
  scale_color_discrete(name = NULL, labels = c("CAETE-IC", "CAETE-PVM")) +
  theme_bw() +
  theme(legend.position = c(0.15,0.07),
        legend.background = element_rect(fill = 'transparent'),
        legend.key = element_rect(fill = 'transparent'))

# ======================================================================

# Saving figs

ggsave(filename = "outputs/figs/runoff_scat.png", plot = scatter_plot ,units = 'in', width = 5.5, height = 5.5, dpi = 300 )

ggsave(filename = "outputs/figs/runoff_line.png", plot = line_plot, units = 'in', width = 8.5, height = 4.5, dpi = 300)

# ======================================================================