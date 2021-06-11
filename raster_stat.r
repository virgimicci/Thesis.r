 # DEM, CHELSA data, maybe Copernicus
 
 setwd("C:/thesis")
 
 library(rgdal)
 library(rgeos)
 library(maptools)
 library(ggplot2)
 library(exactextractr)
library(sf)
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
#funziona solo se cambio il CRS di islands nel CRS dei dati chelsa non al contrario 
# bio1 mean annual air temp 
bio1 <- raster(paste0("CHELSA_bio1_1981-2010_V.2.1.tif"))
mean_annual_air_temp <-  exact_extract(bio1, islands, fun="mean")

# bio2 mean diurnal air temperature range
bio2 <- raster(paste0("CHELSA_bio2_1981-2010_V.2.1.tif"))
mean_diurnal_air_temp <-  exact_extract(bio2, islands, fun="mean")

# bio3 isothermality
bio3 <- raster(paste0("CHELSA_bio3_1981-2010_V.2.1.tif"))
isothermality <-  exact_extract(bio3, islands, fun="mean")

# bio4 temperature seasonality
bio4 <- raster(paste0("CHELSA_bio4_1981-2010_V.2.1.tif"))
temp_seasonality <-  exact_extract(bio4, islands, fun="mean")

# bio5 mean daily maximum  air temperature of the warmest month
bio5 <- raster(paste0("CHELSA_bio5_1981-2010_V.2.1.tif"))
warmestmonth_daily_max_air_t <-  exact_extract(bio5, islands, fun="mean")

# bio6 mean daily minimum air temperature of the coldest month
bio6 <- raster(paste0("CHELSA_bio6_1981-2010_V.2.1.tif"))
coldestmonth_daily_min_air_t <-  exact_extract(bio6, islands, fun="mean")

# bio7 annual range of air temperature
bio7 <- raster(paste0("CHELSA_bio7_1981-2010_V.2.1.tif"))
annual_range_air_temp <-  exact_extract(bio7, islands, fun="mean")

# bio8 mean daily mean air temperatures of the wettest quarter
bio8 <- raster(paste0("CHELSA_bio8_1981-2010_V.2.1.tif"))
mean_daily_airt_wettest_quarter <-  exact_extract(bio8, islands, fun="mean")

# bio9 mean daily mean air temperatures of the driest quarter
bio9 <- raster(paste0("CHELSA_bio9_1981-2010_V.2.1.tif"))
mean_daily_airt_driest_quarter <-  exact_extract(bio9, islands, fun="mean")

# bio10 mean daily mean air temperatures of the warmest quarter
bio10 <- raster(paste0("CHELSA_bio10_1981-2010_V.2.1.tif"))
mean_daily_airt_warmest_quarter <-  exact_extract(bio10, islands, fun="mean")

# bio11 mean daily mean air temperatures of the coldest quarter
bio11 <- raster(paste0("CHELSA_bio11_1981-2010_V.2.1.tif"))
mean_daily_airt_coldest_quarter <-  exact_extract(bio11, islands, fun="mean")

# bio12 annua precipitatiopn amount
bio12<- raster(paste0("CHELSA_bio12_1981-2010_V.2.1.tif"))
annual_prec_amount <-  exact_extract(bio12, islands, fun="mean")

# bio13 precipitation amount of the wettest month
bio13 <- raster(paste0("CHELSA_bio13_1981-2010_V.2.1.tif"))
prec_amount_wettest_month <-  exact_extract(bio13, islands, fun="mean")

# bio 14 precipitation amount of the driest month
bio14 <- raster(paste0("CHELSA_bio14_1981-2010_V.2.1.tif"))
prec_amount_driest_month <-  exact_extract(bio14, islands, fun="mean")

# bio 15 precipitation seasonality
bio15 <- raster(paste0("CHELSA_bio15_1981-2010_V.2.1.tif"))
prec_seasonality <-  exact_extract(bio15, islands, fun="mean")

# bio16 mean monthly precipitation amount of the wettest quarter
bio16 <- raster(paste0("CHELSA_bio16_1981-2010_V.2.1.tif"))
wettestquarter_mean_monthly_prec_amount <-  exact_extract(bio16, islands, fun="mean")

# bio 17 mean monthly precipitation amount of the driest quarter
bio17 <- raster(paste0("CHELSA_bio17_1981-2010_V.2.1.tif"))
driestquarter_mean_monthly_prec_amount <-  exact_extract(bio17, islands, fun="mean")

# bio 18 mean monthly precipitation amount of the warmest quarter
bio18 <- raster(paste0("CHELSA_bio18_1981-2010_V.2.1.tif"))
warmestquarter_mean_monthly_prec_amount <-  exact_extract(bio18, islands, fun="mean")

# bio19 mean mopnthly precipitation amount of the coldest quarter
bio19 <- raster(paste0("CHELSA_bio19_1981-2010_V.2.1.tif"))
coldestquarter_mean_monthly_prec_amount <-  exact_extract(bio19, islands, fun="mean")


islands_dataset<- cbind(islands, mean_annual_air_temp, mean_diurnal_air_temp, 
                        isothermality, temp_seasonality, warmestmonth_daily_max_air_t, 
                        coldestmonth_daily_min_air_t, annual_range_air_temp, mean_daily_airt_wettest_quarter, mean_daily_airt_driest_quarter,
                        mean_daily_airt_warmest_quarter, mean_daily_airt_coldest_quarter, annual_prec_amount, prec_amount_wettest_month, 
                        prec_amount_driest_month, prec_seasonality, wettestquarter_mean_monthly_prec_amount,
                        driestquarter_mean_monthly_prec_amount, warmestquarter_mean_monthly_prec_amount, coldestquarter_mean_monthly_prec_amount)

write.csv(islands_dataset, file = "islands_CHELSA.csv")
csv <- read.csv("islands_CHELSA.csv")
# cambio i nomi delle colonne
colnames(csv)
# ad una sola
colnames(csv)[colnames(csv) == "c.17.4040336608887..15.3491220474243..15.9457778930664..18.9568881988525.."] <-"mean_annual_air_temp"
# a più di una 
colnames(csv)[colnames(csv) %in% c("c.9.96628952026367..8.10937786102295..8.04899501800537..6.98660087585449..", "c.33.9139099121094..32.531005859375..32.1750984191895..28.0153198242188..",
                                   "c.716.860961914062..557.976196289062..566.023803710938..609.406921386719..","c.32.6606903076172..29.0751514434814..29.1826343536377..31.5627002716064..",
                                   "c.3.23800706863403..4.5827202796936..4.72415542602539..7.83865690231323..", "c.29.4226837158203..24.4924297332764..24.4584770202637..23.7240447998047..",
                                    "c.10.516303062439..11.703839302063..11.6576833724976..11.5327234268188..", "c.27.1960525512695..23.6186637878418..23.2695980072021..27.6214771270752..", 
                                   "c.27.3786449432373..23.8412055969238..24.37327003479..27.6214771270752..", "c.8.37838172912598..8.45307922363281..8.79863739013672..11.013689994812.." , 
                                   "c.535.967956542969..665.258483886719..682.982238769531..532.024230957031..", "c.80.8720092773438..103.203788757324..109.121116638184..112.28833770752..", 
                                   "c.13.5855226516724..7.89248609542847..8.84772396087646..2.24855804443359..", "c.52.5802154541016..52.4542999267578..57.9243621826172..89.072380065918..", 
                                   "c.236.894073486328..295.624328613281..311.963500976562..332.427215576172..", "c.44.0108528137207..34.916187286377..33.7720718383789..7.79318284988403.." , 
                                   "c.45.7704238891602..35.589729309082..46.1827201843262..7.79318284988403..", 
                                   "c.187.071243286133..194.134628295898..209.766662597656..286.056945800781..")] <- c( "mean_diurnal_air_temp", 
                        "isothermality", "temp_seasonality", "warmestmonth_daily_max_air_t", 
                        "coldestmonth_daily_min_air_t", "annual_range_air_temp", "mean_daily_airt_wettest_quarter", "mean_daily_airt_driest_quarter",
                       " mean_daily_airt_warmest_quarter", "mean_daily_airt_coldest_quarter", "annual_prec_amount", "prec_amount_wettest_month", 
                        "prec_amount_driest_month", "prec_seasonality", "wettestquarter_mean_monthly_prec_amount",
                        "driestquarter_mean_monthly_prec_amount", "warmestquarter_mean_monthly_prec_amount", "coldestquarter_mean_monthly_prec_amount")
 
write.csv(csv, file = "islands_CHELSA.csv")




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
