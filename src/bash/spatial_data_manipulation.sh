#! /usr/bin/bash

echo "This script uses Climate Data Operators (CDO) to create mean values from CAETE netCDF4 outputs for soil water and runoff data"

cd ../../data/raw/

cdo fldmean ic_wsoil_merge.nc4 ../processed/ic_wsoil_spatial_mean.nc4
cdo fldmean pvm_wsoil_merge.nc4 ../processed/pvm_wsoil_spatial_mean.nc4

cdo timmean ic_wsoil_merge.nc4 ../processed/ic_wsoil_time_mean.nc4
cdo timmean pvm_wsoil_merge.nc4 ../processed/pvm_wsoil_time_mean.nc4

cdo fldmean ic_runoff_merge.nc4 ../processed/ic_runoff_spatial_mean.nc4
cdo fldmean pvm_runoff_merge.nc4 ../processed/pvm_runoff_spatial_mean.nc4

cdo timmean ic_runoff_merge.nc4 ../processed/ic_runoff_time_mean.nc4
cdo timmean pvm_runoff_merge.nc4 ../processed/pvm_runoff_time_mean.nc4
