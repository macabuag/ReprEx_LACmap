library(shiny)
library(shinydashboard)
library(leaflet)
library(sf)

#load("Risk_Database.rdata")
mapData <- read_sf(dsn="ne_50m_admin_0_countries.shp")
myPalette <- colorNumeric(palette = "YlOrBr", domain=mapData$scalerank)

header <- dashboardHeader(title = "Map ReprEx")
sidebar <- dashboardSidebar(disable = T)
body <- dashboardBody(leafletOutput(outputId = "LACmap"))

ui <- dashboardPage(header, sidebar, body)

server <- function(input, output, session) {
  output$LACmap <- renderLeaflet({
    myMap <- leaflet(data = mapData) %>%
      addTiles() %>%
      addPolygons(fillColor = ~myPalette(scalerank))
  })
}

shinyApp(ui, server)