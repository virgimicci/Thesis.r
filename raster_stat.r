 # DEM, CHELSA data
 
wd <- setwd("C:/Users/micci/Documents/Thesis")
  
library(rgdal)
library(rgeos)
library(maptools)
library(ggplot2)
library(exactextractr)
library(sf)
library(raster)
 
islands <- readOGR(paste0("isole_medit_0.5Ha.gpkg"))

write.csv(islands_csv, file = "islands_csv.csv")

# CHELSA, ha un extent div da chelsa per questo non li ho potuti mettere nello stesso stack
wdchelsa <- setwd("C:/Users/micci/Documents/Thesis/chelsa")
list_chelsa<-list.files(pattern="CHELSA")
import_chelsa <- lapply(list_chelsa, raster)
stack_chelsa<- stack(import_chelsa)

# DEM e vari
wd <- setwd("C:/Users/micci/Documents/Thesis")
list_raster<-list.files(pattern=".tif")
import_raster <- lapply(list_raster, raster)
stack_raster<- stack(import_raster)

# exactextractr
island_csv <- cbind(islands, exact_extract(stack_raster, islands,
                             c("min","max", "mean", "median", "stdev",
                               "coefficient_of_variation", "quantile"),
                             quantiles= c(0.25, 0.50, 0.75)), exact_extract(stack_chelsa, islands,
                             c("min","max", "mean", "median", "stdev",
                               "coefficient_of_variation", "quantile"),
                             quantiles= c(0.25, 0.50, 0.75)))


write.csv(islands_csv, file = "islands_csv.csv")

