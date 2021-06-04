 # DEM, CHELSA data, maybe Copernicus
 
 
 setwd("C:/thesis")
 
 library(rgdal)
 library(rgeos)
 library(maptools)
 library(ggplot2)
 library(exactextractr)
 library(raster)
 
#DEM SRTM
DEM <- raster(paste0("DEM.tif"))
islands <- readOGR(paste0("isole_medit_0.5Ha.gpkg"))
 
islands_dem <- cbind(islands, exact_extract(DEM, islands, c("min","max", "mean", "median")))
write.csv(islands_dem, file = "DEMstat.csv")

#DEM aster
DEM_aster <- raster(paste0("dem aster.tif"))

islands <- spTransform(islands, CRSobj="+proj=longlat +datum=WGS84 +no_defs")
islands_demaster <- cbind(islands, exact_extract(DEM_aster, islands, c("min","max", "mean", "median", "quantile"), quantiles= c(0.25, 0.76)))

write.csv(islands_demaster, file = "DEMstataster.csv")

# mean annual air temp 1981-2010 bio1 
# CHELSA_bio1_1981-2010_V.2.1
maat1981_2010 <-raster(paste0("CHELSA_bio1_1981-2010_V.2.1.tif"))
islands_tmean <- cbind(islands, exact_extract(maat1970_2010, islands, c("mean")))
write.csv(islands_tmean, file = "mean_t_1981_2010.csv")

# prediction: mean annual air temp 2071-2100 bio1 
# CHELSA_bio1_2071-2100_gfdl-esm4_ssp585_V.2.1
maat2071_2100 <-raster(paste0("CHELSA_bio1_2071-2100_gfdl-esm4_ssp585_V.2.1.tif"))
islands_tmeanpred <- cbind(islands, exact_extract(maat2071_2100, islands, c("mean")))
write.csv(islands_tmeanpred, file = "mean_t_2071_2100.csv")

# mean annual prec 1981-2010 bio12
# CHELSA_bio12_1981-2010_V.2.1
map1981_2010 <-raster(paste0("CHELSA_bio12_1981-2010_V.2.1.tif"))
islands_pmean <- cbind(islands, exact_extract(map1981_2010, islands, c("mean")))
write.csv(islands_pmean, file = "mean_p_1981_2010.csv")

# prediction : mean annual prec 2070-2100 bio12
# CHELSA_bio12_2071-2100_gfdl-esm4_ssp585_V.2.1
map2070_2100 <-raster(paste0("CHELSA_bio12_2071-2100_gfdl-esm4_ssp585_V.2.1.tif"))
islands_pmeanpred <- cbind(islands, exact_extract(map2070_2100, islands, c("mean")))
write.csv(islands_pmeanpred, file = "mean_p_2070_2100.csv")
