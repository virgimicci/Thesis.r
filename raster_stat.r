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

#DEM aster BETTER
DEM_aster <- raster(paste0("dem aster.tif"))

islands <- spTransform(islands, CRSobj="+proj=longlat +datum=WGS84 +no_defs")
islands_demaster <- cbind(islands, exact_extract(DEM_aster, islands, c("min","max", "mean", "median", "quantile"), quantiles= c(0.25, 0.75)))

write.csv(islands_demaster, file = "DEMstataster.csv")

###DATI CHELSA 1981-2010
# bio1 mean annual air temp 1981-2010 
# CHELSA_bio1_1981-2010_V.2.1
bio1 <- raster(paste0("CHELSA_bio1_1981-2010_V.2.1.tif"))
mean_annual_temp <-  exact_extract(bio1, islands, fun="mean")

islands_tmean <- cbind(islands, exact_extract(maat1970_2010, islands, fun="mean")))
write.csv(islands_tmean, file = "mean_t_1981_2010.csv")

# bio2 mean diurnal air temperature range
bio2 <- raster(paste0("CHELSA_bio1_1981-2010_V.2.1.tif"))
mean_diemp <-  exact_extract(bio1, islands, fun="mean")

# bio3 isothermality
# bio4 temperature seasonality
# bio5 mean daily maximum  air temperature of the warmest month
# bio6 mean daily minimum air temperature of the coldest month
# bio7 annual range of air temperature
# bio7 annual range of air temperature
# bio8 mean daily mean air temperatures of the wettest quarter
# bio9 mean daily mean air temperatures od the driest quarter
# bio10 mean daily mean aie temperatures of the warmest quarter
# bio11 mean daily mean air temperatures of the coldest quarter
# bio12 annual precipitatiopn amount
# bio13 precipitation amount of the wettest month 
# bio 14 precipitation amount of the driest month
# bio 15 precipitation seasonality
# bio16 mean monthly precipitation amount of the wettest quarter
# bio 17 mean monthly precipitation amount of the driest quarter
# bio 18 mean monthly precipitation amount of the warmest quarter
# bio19 mean mopnthly precipitation amount of the coldest quarter 

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
