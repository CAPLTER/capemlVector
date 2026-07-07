test_that("create_vector errors without description", {

  withr::with_tempdir({

    expect_error(
      create_vector(mock_sf_point),
      regexp = "description"
    )

  })

})

test_that("create_vector errors when attrs yaml is missing", {

  withr::with_tempdir({

    # no _attrs.yaml present
    expect_error(
      create_vector(mock_sf_point, description = "a point"),
      regexp = "attributes file not found"
    )

  })

})

test_that("create_vector writes output file and returns spatialVector with projectNaming FALSE", {

  withr::with_tempdir({

    # put fixture in global env so create_vector's get() can find it
    assign("mock_sf_point", mock_sf_point, envir = globalenv())
    withr::defer(rm("mock_sf_point", envir = globalenv()))

    # minimal config.yaml
    writeLines(
      c(
        "scope: knb-lter-cap",
        "identifier: 664",
        "geographic_description: Central Arizona, USA",
        "fileURL: https://data.gios.asu.edu/datasets/cap/"
      ),
      "config.yaml"
    )

    # minimal attrs yaml in named-key format expected by capeml::read_attributes
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

    result <- create_vector(
      vector_name    = mock_sf_point,
      description    = "a test point",
      driver         = "GeoJSON",
      overwrite      = TRUE,
      projectNaming  = FALSE
    )

    expect_true(file.exists("mock_sf_point.geojson"))
    expect_type(result, "list")
    expect_true("entityName" %in% names(result))
    expect_true("entityDescription" %in% names(result))

  })

})
