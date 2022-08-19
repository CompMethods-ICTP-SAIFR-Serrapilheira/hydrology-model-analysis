# ==========================================================

library(ncdf4)

# ==========================================================
# netCDF files loaded as objects:

# reading .nc4 files
runoff_ic_spc_nc <- nc_open("data/processed/ic_runoff_spatial_mean.nc4")
runoff_pvm_spc_nc <- nc_open("data/processed/pvm_runoff_spatial_mean.nc4")

# getting the variables from the file
ic_runoff_spc <- ncvar_get(runoff_ic_spc_nc, 'mrro')
pvm_runoff_spc <- ncvar_get(runoff_pvm_spc_nc, 'mrro')

# ==========================================================

library(ggplot2)
library(zoo)

runoff_df <- cbind.data.frame(ic_runoff_spc, pvm_runoff_spc)

ggplot(runoff_df, aes(x = ic_runoff_spc, y = pvm_runoff_spc)) +
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

ggplot(runoff_rmean_df, aes(x = seq(1,13880,1))) +
  geom_line(aes(y = ic_runoff_rmean, colour = '#CAETE-IC')) +
  geom_line(aes(y = pvm_runoff_rmean, color = '#CAETE-PVM')) +
  labs(x = 'Time (days)', y = 'Water runoff (mm)') +
  scale_x_continuous(breaks = c(0, 365, 3650, 7300, 10950, 13880)) +
  scale_color_manual(name = NULL, values = c("CAETE-IC" = "#111111", "CAETE-PVM" = "#775566")) +
  theme_bw()

# getting the specific data section for comparison:
