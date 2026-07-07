# Minimal sf fixtures shared across capemlVector tests

# single point in WGS 84 (Phoenix, AZ)
mock_sf_point <- sf::st_sf(
  label    = "test_site",
  geometry = sf::st_sfc(sf::st_point(c(-112.07, 33.45)), crs = 4326)
)

# two points — useful for testing bounding-box logic
mock_sf_multipoint <- sf::st_sf(
  label    = c("site_a", "site_b"),
  geometry = sf::st_sfc(
    sf::st_point(c(-112.07, 33.45)),
    sf::st_point(c(-111.90, 33.60)),
    crs = 4326
  )
)
