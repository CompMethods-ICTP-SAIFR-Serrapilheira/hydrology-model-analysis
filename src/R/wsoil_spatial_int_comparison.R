# Script where .nc4 model outputs are loaded and manipulated to prepare them to the analysis
# adicionar no readme que o historico de manipulacao dos dados crus pode ser visto atraves do header do arquivo netcdf
# ==========================================================

library(ncdf4)

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

wsoil_df <- cbind.data.frame(ic_wsoil_spc, pvm_wsoil_spc)

ggplot(wsoil_df, aes(x = ic_wsoil_spc, y = pvm_wsoil_spc)) +
  geom_point(shape = 1, color = "17,17,17", alpha = 0.3) +
  geom_smooth(method = lm) +
  geom_abline(slope = 1, intercept = 0) +
  theme_bw()

ic_wsoil_rmean <- rollmean(ic_wsoil_spc, k = 90, fill = NA)
pvm_wsoil_rmean <- rollmean(pvm_wsoil_spc, k = 90, fill = NA)

wsoil_rmean_df <- cbind.data.frame(ic_wsoil_rmean, pvm_wsoil_rmean)

ggplot(wsoil_rmean_df, aes(x = seq(1,13880,1))) +
  geom_line(aes(y = wsoil_rmean_df$ic_wsoil_rmean), color = '#111111') +
  geom_line(aes(y = wsoil_rmean_df$pvm_wsoil_rmean), color = '#775566') +
  theme_bw()





# CHECKLIST:
  # theme with proper colors;
  # save_fig sessions
  # axis labels
  # timestep in years instead of days



