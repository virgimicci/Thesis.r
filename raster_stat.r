 # DEM, CHELSA data
 
wd <- setwd("C:/Users/micci/Documents/Thesis")
  
library(rgdal)
library(rgeos)
library(maptools)
library(ggplot2)
library(exactextractr)
library(sf)
library(raster)
library(osmdata)
library(mapview)


islands <- readOGR(paste0("isole_medit_0.5Ha.gpkg"))


# CHELSA, ha un extent div da chelsa per questo non li ho potuti mettere nello stesso stack
wdchelsa <- setwd("C:/Users/micci/Documents/Thesis/chelsa")
list_chelsa<-list.files(pattern="CHELSA")
import_chelsa <- lapply(list_chelsa, raster)
stack_chelsa<- stack(import_chelsa)

# DEM e vari
wddem <- setwd("C:/Users/micci/Documents/Thesis/dem_and_co")
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

# Calcolo strade 

library(sf)
library(dplyr)
library(rgdal)

str_is_inters <- readOGR("islands_roads_inters.gpkg")
str_is_inters_df <- as.data.frame(str_is_inters)

street_lenght <- str_is_inters_df %>% 
  group_by(fid_2) %>%
  summarise (total_lenght = sum(Shape_Leng, na.rm = TRUE))

# OSM
islands_sf <- st_as_sf(islands) # only with sf objects
islands_sf <- st_transform(islands_sf, 4326)

bbox_to_string(islands_sf) # mi da solo il primo

osm <- function (x) {opq() %>% # Mediterraneo
    add_osm_feature(key = 'highway') }
apply(islands,1,osm)
osmdata_xml (x, filename="street.osm")

 x <- opq(c(29.7, -5.7, 45.9 , 36.4)) %>% # Mediterraneo
     add_osm_feature(key = 'highway') 

mapview(islands_sf) + st_bbox_by_feature(islands_sf)

