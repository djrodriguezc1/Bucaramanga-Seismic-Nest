library("tidyverse")
library("leaflet")
library("sf")
library("gapminder")
library(ggmap)
library("readxl")
library(tmap)
library(spData)
library(gifski)
library(maps)
Seismic_shapefiles <- read_sf(dsn = "/home/joan/leafletmap/sismos_total")
head(Seismic_shapefiles)
gapminder_most_recent <- gapminder %>%
  mutate_if(is.factor, as.character) %>%
  filter(year == max(year)) %>%
  select(-continent, -year) %>%
  rename(name = country)

gapminder_world <- Seismic_shapefiles %>%
  rename(name = CODIGO)%>%
  palcontinua <- colorNumeric(palette = "YlOrRd", domain = Seismic_shapefiles$MAGNITUD_M, reverse = FALSE)
mybins <- seq(4.5, 6.5, by=0.5)
mypalette <- colorBin( palette="YlOrBr", domain=Seismic_shapefiles$MAGNITUD_M, na.color="transparent", bins=mybins)

gapminder_world %>%
  leaflet()%>%
  addProviderTiles("OpenTopoMap",group = "Topo")%>%
  addProviderTiles("Esri.WorldImagery", group = "Esri") %>%
  addProviderTiles("OpenStreetMap", group = "Street") %>%
  addMiniMap(position = "bottomleft")%>%
  addScaleBar(position = "bottomright")%>%
  addPolygons(weight = 5, label = ~MAGNITUD_M, popup = ~paste("Lugar:",MUNICIPIO, "<br/>","Magnitud:", MAGNITUD_M),
              color = ~mypalette(MAGNITUD_M), opacity = 5)%>%
  
  
  addLayersControl(baseGroups = c("Esri","Topo","Street"),position = c("topleft") ) %>%
  addLegend(data=Seismic_shapefiles,pal = mypalette, values = ~MAGNITUD_M, title = "Bucaramanga Seismic Nest<br>Magnitude >4.5", opacity = 1)%>%
  addSimpleGraticule(interval = 0.5)



