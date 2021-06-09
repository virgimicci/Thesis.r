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

#### roads 
islands_roads.gpkg

### DATI CHELSA 1981-2010 ###
# bio1 mean annual air temp 
bio1 <- raster(paste0("CHELSA_bio1_1981-2010_V.2.1.tif"))
mean_annual_air_temp <-  exact_extract(bio1, islands, fun="mean")

# bio2 mean diurnal air temperature range
bio2 <- raster(paste0("CHELSA_bio1_1981-2010_V.2.1.tif"))
mean_diurnal_air_temp <-  exact_extract(bio2, islands, fun="mean")

# bio3 isothermality
bio3 <- raster(paste0("CHELSA_bio1_1981-2010_V.2.1.tif"))
isothermality <-  exact_extract(bio3, islands, fun="mean")

# bio4 temperature seasonality
bio4 <- raster(paste0("CHELSA_bio1_1981-2010_V.2.1.tif"))
temp_seasonality <-  exact_extract(bio4, islands, fun="mean")

# bio5 mean daily maximum  air temperature of the warmest month
bio5 <- raster(paste0("CHELSA_bio1_1981-2010_V.2.1.tif"))
warmestmonth_daily_max_air_t <-  exact_extract(bio5, islands, fun="mean")

# bio6 mean daily minimum air temperature of the coldest month
bio6 <- raster(paste0("CHELSA_bio1_1981-2010_V.2.1.tif"))
coldestmonth_daily_min_air_t <-  exact_extract(bio6, islands, fun="mean")

# bio7 annual range of air temperature
bio7 <- raster(paste0("CHELSA_bio1_1981-2010_V.2.1.tif"))
annual_range_air_temp <-  exact_extract(bio7, islands, fun="mean")

# bio8 mean daily mean air temperatures of the wettest quarter
bio8 <- raster(paste0("CHELSA_bio1_1981-2010_V.2.1.tif"))
mean_daily_airt_wettest_quarter <-  exact_extract(bio8, islands, fun="mean")

# bio9 mean daily mean air temperatures of the driest quarter
bio9 <- raster(paste0("CHELSA_bio1_1981-2010_V.2.1.tif"))
mean_daily_airt_driest_quarter <-  exact_extract(bio9, islands, fun="mean")

# bio10 mean daily mean air temperatures of the warmest quarter
bio10 <- raster(paste0("CHELSA_bio1_1981-2010_V.2.1.tif"))
mean_daily_airt_warmest_quarter <-  exact_extract(bio10, islands, fun="mean")

# bio11 mean daily mean air temperatures of the coldest quarter
bio11 <- raster(paste0("CHELSA_bio1_1981-2010_V.2.1.tif"))
mean_daily_airt_coldest_quarter <-  exact_extract(bio11, islands, fun="mean")

# bio12 annua precipitatiopn amount
bio12<- raster(paste0("CHELSA_bio12_1981-2010_V.2.1.tif"))
annual_prec_amount <-  exact_extract(bio12, islands, fun="mean")

# bio13 precipitation amount of the wettest month
bio13 <- raster(paste0("CHELSA_bio1_1981-2010_V.2.1.tif"))
prec_amount_wettest_month <-  exact_extract(bio13, islands, fun="mean")

# bio 14 precipitation amount of the driest month
bio14 <- raster(paste0("CHELSA_bio1_1981-2010_V.2.1.tif"))
prec_amount_driest_month <-  exact_extract(bio14, islands, fun="mean")

# bio 15 precipitation seasonality
bio15 <- raster(paste0("CHELSA_bio1_1981-2010_V.2.1.tif"))
prec_seasonality <-  exact_extract(bio15, islands, fun="mean")

# bio16 mean monthly precipitation amount of the wettest quarter
bio16 <- raster(paste0("CHELSA_bio1_1981-2010_V.2.1.tif"))
wettestquarter_mean_monthly_prec_amount <-  exact_extract(bio16, islands, fun="mean")

# bio 17 mean monthly precipitation amount of the driest quarter
bio17 <- raster(paste0("CHELSA_bio1_1981-2010_V.2.1.tif"))
driestquarter_mean_monthly_prec_amount <-  exact_extract(bio17, islands, fun="mean")

# bio 18 mean monthly precipitation amount of the warmest quarter
bio18 <- raster(paste0("CHELSA_bio1_1981-2010_V.2.1.tif"))
warmestquarter_mean_monthly_prec_amount <-  exact_extract(bio18, islands, fun="mean")

# bio19 mean mopnthly precipitation amount of the coldest quarter
bio19 <- raster(paste0("CHELSA_bio1_1981-2010_V.2.1.tif"))
coldestquarter_mean_monthly_prec_amount <-  exact_extract(bio19, islands, fun="mean")


islands_dataset<- cbind(islands, bio1, bio2, bio3, bio4, bio5, bio6, bio7, bio8, bio9, bio10, bio11, bio12, bio13, bio14, bio15, bio16, bio17, bio18, bio19)
write.csv(islands_tmean, file = "islands_dataset.csv")



# prediction: mean annual air temp 2071-2100 bio1 
# CHELSA_bio1_2071-2100_gfdl-esm4_ssp585_V.2.1
maat2071_2100 <-raster(paste0("CHELSA_bio1_2071-2100_gfdl-esm4_ssp585_V.2.1.tif"))
islands_tmeanpred <- cbind(islands, exact_extract(maat2071_2100, islands, c("mean")))
write.csv(islands_tmeanpred, file = "mean_t_2071_2100.csv")

# prediction : mean annual prec 2070-2100 bio12
# CHELSA_bio12_2071-2100_gfdl-esm4_ssp585_V.2.1
map2070_2100 <-raster(paste0("CHELSA_bio12_2071-2100_gfdl-esm4_ssp585_V.2.1.tif"))
islands_pmeanpred <- cbind(islands, exact_extract(map2070_2100, islands, c("mean")))
write.csv(islands_pmeanpred, file = "mean_p_2070_2100.csv")
