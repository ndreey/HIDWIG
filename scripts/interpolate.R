# Function to generate a grid overlay of the world.
create_grid_overlay <- function(world, cell_size = 0.2, sf_df) {
  bbox <- st_bbox(world)
  x <- seq(bbox$xmin, bbox$xmax, by = cell_size)
  y <- seq(bbox$ymin, bbox$ymax, by = cell_size)
  w_grid <- expand.grid(x = x, y = y)  
  w_grid$tmp <- 1  # Temporary variable for conversion
  
  w_grid <- st_as_stars(w_grid, dims = c("x", "y"), crs = st_crs(world))
  st_crs(w_grid) <- st_crs(sf_df)
  
  return(w_grid)
}


idw_interpolation <- function(sf_df, area, formula = Dist ~ 1, idp = 2, 
                              cache_dir = "00_DATA/interpolation_RDS") {
  # Generate unique identifiers for sf_df, area, and parameters
  sf_df_id <- digest(sf_df)
  area_id <- digest(area)
  # Convert formula to a string representation and generate an identifier
  formula_id <- digest(deparse(formula))
  # Include idp in the cache file name
  cache_file_name <- paste0("idw_cache_", sf_df_id, "_", area_id, "_", 
                            formula_id, "_idp", idp, ".rds")
  cache_file_path <- file.path(cache_dir, cache_file_name)
  
  if (!file.exists(cache_file_path)) {
    # Perform the interpolation if cache does not exist
    interpolated_data <- gstat::idw(formula = formula, locations = sf_df, newdata = area, idp = idp)
    # Save the interpolated data to the cache
    saveRDS(interpolated_data, cache_file_path)
  } else {
    # Load interpolated data from cache if it exists
    interpolated_data <- readRDS(cache_file_path)
  }
  
  return(interpolated_data)
}




