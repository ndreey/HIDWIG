# HIDWIG <img src="www/logo.png" alt="logo" width="181" align="right"/>
HIDWIG, or Heatmap by Inverse Distance Weight Interpolation of Genetic distances, is a novel R Shiny application for spatial visualization of genetic distances among populations. It uses inverse distance weight interpolation to generate heatmaps at various geographical levels, simplifying the analysis of genetic data across different time periods.

## Usage
Launch the R Shiny application.
Input requires an Excel file with genetic distances, geographic coordinates, and population identifiers.
Users can select time periods for separate visualizations.
Generates heatmaps for country, continent, and global scales.

### Packages
shiny                   1.8.0
shinythemes             1.2.0
tidyverse               2.0.0
readxl                  1.4.3
sf                      1.0.15
mapview                 2.11.2
rnaturalearth           1.0.1
stars                   0.6.4
gstat                   2.1.1
digest                  0.6.34
leaflet                 2.2.1
viridis                 0.6.5

## Features
User-friendly interface for loading data and specifying parameters.
Supports visualization for distinct time periods.
Interactive maps allow for in-depth analysis of genetic distances.


For further details and support, contact andre.bourbonnais@student.lu.se.
