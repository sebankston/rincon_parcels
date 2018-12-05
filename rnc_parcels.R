library(tidyverse)
library(sf)
library(leaflet)
library(leaflet.extras)
library(googlesheets)
library(janitor)
library(htmlwidgets)

rnc_parcels <- st_read(layer = "ParcelDetail4c4f0282d30c4b80a28f912df10e38ed", dsn = ".") %>% st_transform(crs = 4326) %>% clean_names()

rnc_deets <- read_csv("rincon_detailed_assessments.csv")

leaflet() %>% 
  addProviderTiles("Esri.WorldStreetMap", group = "Street Map") %>% 
  addProviderTiles("Esri.WorldImagery",group = "World Imagery") %>%
  addPolygons(data = rnc_parcels, weight = 2, color = "blue", label = ~paste0("Owner: ", owner_9b), highlight = highlightOptions(weight = 3,color = "red",bringToFront = FALSE), group = "Parcels", opacity = .75) %>% 
  addCircleMarkers(data = rnc_deets, label = rnc_deets$barrier_id, popup = ~paste0(rnc_deets$barrier_id, "<br />", rnc_deets$PAD_id), radius = 5, color = "red", fillOpacity = 1, group = "Barriers") %>% 
  addLayersControl(baseGroups = c("Street Map", "World Imagery"), overlayGroups = c("Parcels", "Barriers"))


  