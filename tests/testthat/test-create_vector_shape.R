test_that("create_vector_shape errors without description", {

  withr::with_tempdir({

    expect_error(
      create_vector_shape(mock_sf_point, coord_sys = "GCS_WGS_1984"),
      regexp = "description"
    )

  })

})

test_that("create_vector_shape errors without coord_sys", {

  withr::with_tempdir({

    expect_error(
      create_vector_shape(mock_sf_point, description = "a point"),
      regexp = "coordinate reference system"
    )

  })

})

test_that("create_vector_shape writes zip and returns spatialVector with projectNaming FALSE", {

  withr::with_tempdir({

    assign("mock_sf_point", mock_sf_point, envir = globalenv())
    withr::defer(rm("mock_sf_point", envir = globalenv()))

    writeLines(
      c(
        "scope: knb-lter-cap",
        "identifier: 664",
        "geographic_description: Central Arizona, USA",
        "fileURL: https://data.gios.asu.edu/datasets/cap/"
      ),
      "config.yaml"
    )

    writeLines(
      c(
        "label:",
        "  attributeName: label",
        "  attributeDefinition: site label",
        "  propertyURI: ''",
        "  propertyLabel: ''",
        "  valueURI: ''",
        "  valueLabel: ''",
        "  columnClasses: character",
        "  definition: ''"
      ),
      "mock_sf_point_attrs.yaml"
    )

    result <- create_vector_shape(
      vector_name   = mock_sf_point,
      description   = "a test point shapefile",
      coord_sys     = "GCS_WGS_1984",
      overwrite     = TRUE,
      projectNaming = FALSE
    )

    expect_true(file.exists("mock_sf_point.zip"))
    expect_type(result, "list")
    expect_true("entityName" %in% names(result))
    expect_true("entityDescription" %in% names(result))

  })

})
