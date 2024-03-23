
# Function to load data from an Excel file
get_data <- function(file_path) {
  data <- read_excel(file_path)
  return(data)
}

# Function to filter data based on user selections
filter_data <- function(data, era_col, era_values) {
  # Filter data based on the selected era
  filtered_data <- data %>%
    filter(
      get(era_col) %in% era_values,
    )
  
  return(filtered_data)
}

# Function to convert a data frame to an sf object
make_sf <- function(dataframe, longitude = "Long", latitude = "Lat", c.sys = "EPSG:4326") {
  # Ensure the specified longitude and latitude columns exist in the dataframe
  if (!all(c(longitude, latitude) %in% names(dataframe))) {
    stop("Specified longitude or latitude columns do not exist in the dataframe")
  }
  
  # Convert to sf using specified longitude and latitude columns
  sf <- dataframe %>% 
    st_as_sf(coords = c(longitude, latitude), crs = c.sys)
  return(sf)
}

# Function to load and cache a medium-scale map of the world
load_world_map <- function(cache_path = "00_DATA/RDS/world_cache.rds") {
  if (!file.exists(cache_path)) {
    world <- ne_countries(scale = "medium", returnclass = "sf")
    saveRDS(world, cache_path)
  } else {
    world <- readRDS(cache_path)
  }
  return(world)
}

# Function to load continents and transform CRS to match other spatial data
load_continents <- function(
    file_path = "00_DATA/World_Continents/World_Continents.shp", 
    cache_path = "00_DATA/RDS/continents_cache.rds", # Add a parameter for cache path
    c.sys = "EPSG:4326") {
  
  # Check if the cache file exists
  if (!file.exists(cache_path)) {
    # If the cache does not exist, read the shapefile and transform CRS
    continents <- st_read(file_path)
    continents <- st_transform(continents, crs = c.sys)
    # Save the transformed continents to the cache path
    saveRDS(continents, cache_path)
  } else {
    # If the cache exists, read the continents from the cache
    continents <- readRDS(cache_path)
  }
  
  return(continents)
}


# Function to load and potentially cache landmass data
load_landmass <- function(cache_path = "00_DATA/RDS/landmass_cache.rds") {
 if (!file.exists(cache_path)) {
   landmass <- st_read("00_DATA/polygon_landmass/land_polygons.shp")
   saveRDS(landmass, cache_path)
 } else {
   landmass <- readRDS(cache_path)
 }
 return(landmass)
}


