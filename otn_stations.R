otn_metadata_query <- paste0(
  "https://members.oceantrack.org/geoserver/otn/ows?",
  "service=WFS&version=1.0.0&request=GetFeature&typeName=otn:",
  'stations',
  "&outputFormat=csv"
  ) |>
  URLencode() |> 
  read.csv()

dir.create("distribute")

otn_metadata_query[
  !is.na(otn_metadata_query$longitude) | !is.na(otn_metadata_query$latitude),] |> 
  sf::st_as_sf(
    coords = c("longitude", "latitude"),
    crs = 4326
  ) |> 
  sf::st_write("distribute/otn_stations.pmtiles",
         driver = "PMTiles")
