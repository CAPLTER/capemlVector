test_that("create_geographic_coverage returns correctly structured list", {

  result <- create_geographic_coverage(mock_sf_point, "test site")

  expect_type(result, "list")
  expect_named(result, c("geographicDescription", "boundingCoordinates"))
  expect_named(
    result$boundingCoordinates,
    c(
      "westBoundingCoordinate",
      "eastBoundingCoordinate",
      "northBoundingCoordinate",
      "southBoundingCoordinate"
    )
  )

})

test_that("create_geographic_coverage populates description correctly", {

  result <- create_geographic_coverage(mock_sf_point, "Phoenix monitoring site")

  expect_equal(result$geographicDescription, "Phoenix monitoring site")

})

test_that("create_geographic_coverage computes correct bounding box", {

  result <- create_geographic_coverage(mock_sf_multipoint, "two sites")
  bbox   <- result$boundingCoordinates

  expect_equal(bbox[["westBoundingCoordinate"]],  -112.07)
  expect_equal(bbox[["eastBoundingCoordinate"]],  -111.90)
  expect_equal(bbox[["southBoundingCoordinate"]], 33.45)
  expect_equal(bbox[["northBoundingCoordinate"]], 33.60)

})

test_that("create_geographic_coverage errors on non-sf input", {

  expect_error(
    create_geographic_coverage(data.frame(x = 1), "bad input"),
    regexp = "sf object"
  )

})

test_that("create_geographic_coverage errors on empty sf object", {

  empty_sf <- sf::st_sf(
    label    = character(0),
    geometry = sf::st_sfc(crs = 4326)
  )

  expect_error(
    create_geographic_coverage(empty_sf, "empty"),
    regexp = "empty"
  )

})
