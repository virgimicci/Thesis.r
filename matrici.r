 wd<- setwd("C:/Thesis")
 library(rgdal)
 islands <- readOGR(paste0("Isole mediterraneo 0.5 Ha.gpkg"))
 coastline <- readOGR(paste0("coastline_eur_afr.gpkg"))
 
distance <- st_distance( islands, coastline, by_element= TRUE) #nopeeeeee
