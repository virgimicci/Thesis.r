wd<- setwd("C:/Thesis")
library(raster)
library(sf)
list.files(wd)
islands <- st_read("isole_medit_0.5Ha.gpkg" )
islands1 <- st_read("1º.gpkg")
islands<- st_read("microgruppo perprova.gpkg") #MULTIPOLYGONS
grid <- st_make_grid(islands,cellsize = 1000,what="centers")
grid <- st_intersection(grid, islands)
plot(grid)

coastline <-st_read("coastlines_eurafr.gpkg") #MULTILYNESTRING
# gia tiene la CRS uglae

dist <- st_distance( coastline, islands)
