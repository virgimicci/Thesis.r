wd <- setwd("C:/Users/micci/Documents/Thesis")
library(raster)
library(sf)
library(dplyr)
list.files(wd)

islands<- st_read("microgruppo perprova.gpkg") #MULTIPOLYGONS crs:  WGS 84 / UTM zone 33N
coastline <-st_read("coastline_eur_afr.gpkg") # MULTIPOLYGON
coastline <- st_transform(coastline, crs(islands))
 
#### Distanza minima isola-continente
# metodo 2 (Funziona!)
index <- st_nearest_feature(x = islands, y = coastline) # create an index of the nearest feature
slice_coastline <- coastline %>% slice(index) # slice based on the index
dist <- st_distance(x = islands, y= slice_coastline, by_element = TRUE) # calculate distance between polygons
dist
# add the distance calculations to the islands polygons
islands$Dist_continent <- dist

###### metodo 1 (nope) ##################################
grid <- st_make_grid(islands,cellsize = 1000,what="centers")
grid <- st_intersection(grid, islands)
plot(grid)
coastline <-st_read("coastlines_eurafr.gpkg") #MULTILYNESTRING modificato in gis
# gia tiene la CRS uglae
dist <- st_distance(coastline, grid)
min.dist <- apply(dist.df,1, FUN=min)
#################################################33

#### Distance matrix islands
dist_matrix <- st_distance(islands)
min_dist <- apply (dist_matrix, 1, function (x) min(x[x>0]))  # extract the min distance for each island
islands$nearest_dist <- min_dist  # add the distance calculations to the islands polygons      
                                      
#### Ciclo: dist prossima isola più grande
                   
