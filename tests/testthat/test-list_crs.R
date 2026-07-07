test_that("list_crs returns a non-empty character vector", {

  skip_if_offline()

  result <- list_crs()

  expect_type(result, "character")
  expect_gt(length(result), 100L)

})

test_that("list_crs result contains known CRS names", {

  skip_if_offline()

  result <- list_crs()

  expect_true("GCS_WGS_1984" %in% result)
  expect_true(any(grepl("UTM", result)))

})
