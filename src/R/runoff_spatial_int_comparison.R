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
  geom_point(shape = 1, color = "17,17,17", alpha = 0.3) +
  geom_smooth(method = lm) +
  geom_abline(slope = 1, intercept = 0) +
  theme_bw()

ic_runoff_rmean <- rollmean(ic_runoff_spc, k = 90, fill = NA)
pvm_runoff_rmean <- rollmean(pvm_runoff_spc, k = 90, fill = NA)

runoff_rmean_df <- cbind.data.frame(ic_runoff_rmean, pvm_runoff_rmean)

ggplot(runoff_rmean_df, aes(x = seq(1,13880,1))) +
  geom_line(aes(y = runoff_rmean_df$ic_runoff_rmean), color = '#111111') +
  geom_line(aes(y = runoff_rmean_df$pvm_runoff_rmean), color = '#775566') +
  theme_bw()

# getting the specific data section for comparison:
