test_that("package_vector_shape errors without description", {

  withr::with_tempdir({

    expect_error(
      package_vector_shape(dsn = ".", layer = "test", coord_sys = "GCS_WGS_1984"),
      regexp = "description"
    )

  })

})

test_that("package_vector_shape errors without coord_sys", {

  withr::with_tempdir({

    expect_error(
      package_vector_shape(dsn = ".", layer = "test", description = "a shapefile"),
      regexp = "coordinate reference system"
    )

  })

})

test_that("package_vector_shape writes zip and returns spatialVector", {

  withr::with_tempdir({

    # write a real shapefile to a sub-directory so the function can harvest it
    shp_dir <- "shapefiles"
    dir.create(shp_dir)

    sf::st_write(
      obj    = mock_sf_point,
      dsn    = file.path(shp_dir, "test_layer.shp"),
      driver = "ESRI Shapefile",
      quiet  = TRUE
    )

    # read the layer back and put in globalenv so capeml::read_attributes can find it
    test_layer <- sf::st_read(shp_dir, layer = "test_layer", quiet = TRUE)
    assign("test_layer", test_layer, envir = globalenv())
    withr::defer(rm("test_layer", envir = globalenv()))

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
      "test_layer_attrs.yaml"
    )

    result <- package_vector_shape(
      dsn           = shp_dir,
      layer         = "test_layer",
      description   = "a test shapefile",
      coord_sys     = "GCS_WGS_1984",
      overwrite     = TRUE,
      projectNaming = FALSE
    )

    expect_true(file.exists("test_layer.zip"))
    expect_type(result, "list")
    expect_true("entityName" %in% names(result))
    expect_true("entityDescription" %in% names(result))

  })

})
