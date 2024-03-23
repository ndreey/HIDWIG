
create_map <- function(data, layer_name = "Data Layer", 
                       map_type = "OpenStreetMap", alpha = 0.8) {
  map <- mapview(    data, zcol = "var1.pred", layer.name = layer_name, 
                     map.types = map_type, alpha = alpha)
  return(map)
}
