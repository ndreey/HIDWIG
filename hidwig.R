# Required libraries
library(shiny)
library(shinythemes)
library(tidyverse)
library(readxl)
library(sf)
library(mapview)
library(rnaturalearth)
library(stars)
library(gstat)
library(leaflet)
library(digest)
library(viridis)

# Sourced functions from scripts
source("scripts/data_loading.R")
source("scripts/interpolate.R")
source("scripts/visualize.R")

ui <- fluidPage(
  theme = shinytheme("slate"), # Apply the theme
  navbarPage(
    "HIDWIG",  # Fancy app name
    # This sets the setting windows for the map generator
    tabPanel("Map",
             fluidRow(
               column(3,
                      wellPanel(
                        fileInput("dataFile", "Choose File", accept = ".xlsx"),
                        actionButton("loadData", "Load Data", class = "btn-primary"),
                        actionButton("genMap", "Generate Map", class = "btn-success")
                      )
               ),
               column(3,
                      wellPanel(
                        uiOutput("latSelector"),
                        uiOutput("longSelector"),
                        uiOutput("distSelector")
                      )
               ),
               column(3,
                      wellPanel(
                        uiOutput("eraSelector"),
                        uiOutput("eraValuesSelector")
                      )
               ),
               column(3,
                      wellPanel(
                        textInput("crs", "Coordinate System", value = "EPSG:4326"),
                        numericInput("cellSize", "Cell Size", value = 0.2, min = 0.2),
                        numericInput("idp", "IDP", value = 2, min = 1)
                      )
               )
             ),
             fluidRow(
               column(12,
                      leafletOutput("map", height = "600px")
               )
             )
    ),
    # Adding "About" tab
    tabPanel("About",
             h2("About"),
             p("This application is designed to lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam non augue nibh. Aliquam erat volutpat. Nulla ut elementum arcu. Nam tempus suscipit pretium. Morbi ac dolor imperdiet, fringilla diam eu, euismod nibh. Nam in tellus turpis. In aliquet consectetur hendrerit. Curabitur tristique metus gravida, consectetur elit vel, posuere ante. Phasellus aliquam, massa eget posuere ullamcorper, nulla nulla fringilla mauris, ut bibendum justo turpis at tellus. Nam lorem odio, malesuada a rhoncus sed, egestas sagittis massa. Quisque luctus dui ac augue sollicitudin faucibus. Etiam dapibus et magna sed varius. Integer nec hendrerit tortor. Sed vel laoreet nisl, sit amet euismod urna. Morbi consequat enim et vehicula congue."),
             p("Quisque hendrerit, dui ac bibendum efficitur, eros velit aliquam est, eget tempor mi diam ac enim. Donec nunc nisl, iaculis id mattis ut, laoreet ac nibh. Curabitur accumsan purus quis laoreet venenatis. Ut dictum facilisis posuere. In vel feugiat tortor. Duis eget cursus dui. Donec est lectus, cursus et risus eget, rutrum ultrices ligula. Maecenas tempor dolor ac condimentum tincidunt. Aenean vestibulum quis ligula sed congue. Cras risus purus, mattis non eros ac, volutpat dapibus metus. Nunc eu eros eget libero suscipit lobortis vitae eget nisi. Vestibulum eget purus aliquet, vulputate nisl sed, venenatis velit. Pellentesque consequat quis justo non vulputate. In hac habitasse platea dictumst."),
             p("Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
            ),
    
    # Adding "Help" tab
    tabPanel("Help",
             # Similarly, include any helpful information, instructions, FAQs, etc.
             h2("Help & Instructions"),
             p("For help with using this app, start by Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam non augue nibh. Aliquam erat volutpat. Nulla ut elementum arcu. Nam tempus suscipit pretium. Morbi ac dolor imperdiet, fringilla diam eu, euismod nibh. Nam in tellus turpis. In aliquet consectetur hendrerit. Curabitur tristique metus gravida, consectetur elit vel, posuere ante. Phasellus aliquam, massa eget posuere ullamcorper, nulla nulla fringilla mauris, ut bibendum justo turpis at tellus. Nam lorem odio, malesuada a rhoncus sed, egestas sagittis massa. Quisque luctus dui ac augue sollicitudin faucibus. Etiam dapibus et magna sed varius. Integer nec hendrerit tortor. Sed vel laoreet nisl, sit amet euismod urna. Morbi consequat enim et vehicula congue.
Quisque hendrerit, dui ac bibendum efficitur, eros velit aliquam est, eget tempor mi diam ac enim. Donec nunc nisl, iaculis id mattis ut, laoreet ac nibh. Curabitur accumsan purus quis laoreet venenatis. Ut dictum facilisis posuere. In vel feugiat tortor. Duis eget cursus dui. Donec est lectus, cursus et risus eget, rutrum ultrices ligula. Maecenas tempor dolor ac condimentum tincidunt. Aenean vestibulum quis ligula sed congue. Cras risus purus, mattis non eros ac, volutpat dapibus metus. Nunc eu eros eget libero suscipit lobortis vitae eget nisi. Vestibulum eget purus aliquet, vulputate nisl sed, venenatis velit. Pellentesque consequat quis justo non vulputate. In hac habitasse platea dictumst.
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse varius magna pharetra efficitur pharetra. Morbi sed aliquam leo. Pellentesque ornare turpis erat. Maecenas ultricies vulputate odio quis pharetra. Aliquam tempus nec neque eu aliquet. Nullam sed aliquet arcu. Interdum et malesuada fames ac ante ipsum primis in faucibus. Aenean euismod egestas sapien, vitae maximus justo volutpat ac. Sed cursus erat in lacus suscipit vehicula.
Sed blandit lectus ut arcu placerat fringilla. Nunc eu augue in leo malesuada iaculis nec aliquam dolor. Suspendisse feugiat lorem vel leo scelerisque, vel congue urna semper. Morbi facilisis ullamcorper scelerisque. Etiam dictum sodales arcu id pharetra. Morbi quis mattis felis, a commodo purus. Proin consequat tellus dolor, non hendrerit velit porta nec.
Integer id augue turpis. Sed a est nulla. Quisque lacus nisi, cursus eu mauris in, mollis elementum nulla. Suspendisse vitae urna id leo semper consequat. Nunc risus nisi, vulputate nec sem eget, bibendum egestas eros. In hac habitasse platea dictumst. Nulla nisl augue, posuere ut laoreet ac, condimentum ac lacus. Nulla at consequat velit. In hac habitasse platea dictumst. Etiam non rutrum tellus.")
    )
  )
)


server <- function(input, output, session) {
  # Reactive value to hold the uploaded data
  uploadedData <- reactiveVal()
  
  # Observe event for Load Data button
  observeEvent(input$loadData, {
    req(input$dataFile)
    
    # Call the get_data function from data_loading.R script
    data <- get_data(input$dataFile$datapath)
    uploadedData(data) # Store the data in the reactive value
    
    # Update the UI elements for the latitude and longitude selectors
    output$latSelector <- renderUI({
      selectInput("lat", "Latitude Column", choices = names(uploadedData()))
    })
    
    output$longSelector <- renderUI({
      selectInput("long", "Longitude Column", choices = names(uploadedData()))
    })
    
    output$distSelector <- renderUI({
      selectInput("dist", "Distance Column", choices = names(uploadedData()))
    })
    
    # Update the UI element for the era selector
    output$eraSelector <- renderUI({
      selectInput("era", "Era Column", choices = names(uploadedData()))
    })
  })
  
  # Dynamically update era values selector based on selected era column
  output$eraValuesSelector <- renderUI({
    req(uploadedData()) # Ensure there is uploaded data
    # Ensure there's a selected era column to avoid NULL issues
    selectedEraColumn <- uploadedData()
    # Generate the dropdown menu for selecting multiple era values.
    selectInput("selectedEraValues", "Select Era Values", 
                  choices = unique(selectedEraColumn))
    })
  
  # Observe event for the 'Generate Map' button
  observeEvent(input$genMap, {
    req(uploadedData(), input$selectedEraValues)
    
  
    # Get the filtered data based on user selections
    filtered_data <- filter_data(
      uploadedData(), 
      input$era,
      input$selectedEraValues
    )
    
    ### Load in data
    world <- load_world_map()
    cont <- load_continents()
    sf_df <- make_sf(filtered_data, input$long, input$lat, input$crs )  
    
    # Rename the column input$dist to Dist as there were some errors
    names(sf_df)[names(sf_df) == input$dist] <- "Dist"
    
    # Generate grid
    grid <- create_grid_overlay(world, input$cellSize, sf_df)
    
    # Interpolation
    grid.idw <- idw_interpolation(sf_df, grid, Dist ~ 1, input$idp)
    world.idw <- idw_interpolation(sf_df, world, Dist ~ 1, input$idp)
    cont.idw <- idw_interpolation(sf_df, cont, Dist ~ 1, input$idp)
    
    ### Render map 
    # Color palette
    pal <- viridis(256, option = "viridis")
    
    # Gradient sequence
    gradient <- seq(0, max(sf_df$Dist)+0.05, 0.05)
    
    # Plot the spatial objects and their layers with predicted values.
    output$map <- renderLeaflet({
      map <- mapview(grid.idw,
                     zcol="var1.pred",
                     col.regions = pal, 
                     at = gradient,
                     layer.name = "Grid",
                     alpha.regions = 0.65) +
        mapview(world.idw, 
                zcol="var1.pred",
                col.regions = pal, 
                at = gradient,
                layer.name = "Countries") +
        mapview(cont.idw, zcol="var1.pred",
                layer.name = "Continents",
                at = gradient) +
        mapview(sf_df, cex = 6)
      
      map@map
    })
  })
}

shinyApp(ui = ui, server = server)
