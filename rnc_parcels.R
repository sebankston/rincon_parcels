library(tidyverse)
library(sf)
library(leaflet)
library(leaflet.extras)
library(googlesheets)
library(janitor)
library(htmlwidgets)

rnc_parcels <- st_read(layer = "ParcelDetail4c4f0282d30c4b80a28f912df10e38ed", dsn = ".") %>% st_transform(crs = 4326)

rnc_deets <- read_csv("rincon_detailed_assessments.csv")

leaflet() %>% 
  addProviderTiles("Esri.WorldStreetMap", group = "Street Map") %>% 
  addProviderTiles("Esri.WorldImagery",group = "World Imagery") %>% 
  addCircleMarkers(data = rnc_r2, label = rnc_r2$barrier_id, popup = ~paste0(rnc_r2$barrier_id, "<br/>", rnc_r2$pad_id), color = "red", group = "Detailed Required", radius = 5, fillOpacity = .5) %>% 
  addCircleMarkers(data = rnc_nr, label = rnc_nr$barrier_id, popup = ~paste0(rnc_nr$barrier_id, "<br/>", rnc_nr$pad_id), color = "dodgerblue", group = "Non-Road Barrier", radius = 3, fillOpacity = 1) %>%
  addCircleMarkers(data = rnc_r, label = rnc_r$barrier_id, popup = ~paste0(rnc_r$barrier_id, "<br/>", rnc_r$pad_id), color = "green", group = "Road Barrier", radius = 3, fillOpacity = 1) %>%
  addLayersControl(baseGroups = c("Street Map", "World Imagery"), overlayGroups = c("Non-Road Barrier", "Road Barrier", "Detailed Required"))