<!-- README.md is generated from README.Rmd. Please edit that file. -->

<br>
<br>

## capemlVector: tools to generate EML metadata for spatial vector data

### overview

`capemlVector` is a companion package to
[CAPLTER/capeml](https://github.com/CAPLTER/capeml) that facilitates the
creation of Ecological Metadata Language (EML) `spatialVector` entities
from spatial data objects in R for publishing to the
[Environmental Data Initiative (EDI)](https://edirepository.org/) data
repository. The package also provides `create_geographic_coverage()` for
generating EML geographic coverage elements directly from simple features
objects.

The capeml package ecosystem:

| package | scope |
|---|---|
| [capeml](https://github.com/CAPLTER/capeml) | tabular data, dataset-level metadata |
| capemlVector | spatial vector data (KML, GeoJSON, shapefile) |
| [capemlGIS](https://github.com/CAPLTER/capemlGIS) | spatial raster data |

### installation

Install with [pak](https://pak.r-lib.org/):

``` r
# install pak if needed
# install.packages("pak")

pak::pak("CAPLTER/capemlVector")
```

`capemlVector` depends on [capeml](https://github.com/CAPLTER/capeml),
which will be installed automatically via the `Remotes` field when using
`pak`.

### getting started

Creating an EML dataset starts with the
[CAPLTER/capeml](https://github.com/CAPLTER/capeml) package.
`capemlVector` is designed to create EML entities of type
`spatialVector`; users should begin with the `capeml` workflow, including
creating a `config.yaml` in the working directory that contains
project-level metadata required by the vector functions.

A minimal `config.yaml` includes:

```yaml
scope: knb-lter-cap
identifier: 664
geographic_description: "Central Arizona, USA"
fileURL: "https://data.gios.asu.edu/datasets/cap/"
```

### options

#### EML version

This package defaults to the current version of EML. Users can switch to
the previous version with `emld::eml_version("eml-2.1.1")`.

#### project naming

Vector functions will name output files with the format
`identifier`\_`object-name`.`file-extension` (e.g.,
*664\_site\_map.geojson*) when `projectNaming = TRUE` (the default). The
identifier is read from `config.yaml`. Set `projectNaming = FALSE` to
use the object name as-is.

### functions

| function | output | description |
|---|---|---|
| `create_vector()` | KML or GeoJSON file + EML `spatialVector` | writes a new vector file from an sf object in the R environment |
| `create_vector_shape()` | zipped ESRI shapefile + EML `spatialVector` | writes a new shapefile from an sf object in the R environment |
| `package_vector_shape()` | zipped ESRI shapefile + EML `spatialVector` | packages existing shapefile files without creating a new spatial object |
| `create_geographic_coverage()` | EML geographic coverage list | generates bounding coordinates from an sf object for inclusion in EML coverage |
| `list_crs()` | character vector | returns EML-compliant coordinate reference system names |

### workflow: prepare attribute metadata

Before calling any `create_*` function, generate attribute metadata
templates with `capeml`:

``` r
# generate _attrs.yaml template from an sf object
capeml::write_attributes(my_vector, overwrite = FALSE)

# if the vector has factor columns, also generate factors template
capeml::write_factors(my_vector, overwrite = FALSE)
```

Edit the generated `my_vector_attrs.yaml` (and `my_vector_factors.yaml`
if applicable) to supply definitions, units, and any other attribute
metadata.

### workflow: create a spatialVector — output to GeoJSON or KML

`create_vector()` writes the spatial data to a GeoJSON (default) or KML
file and returns an EML `spatialVector` object. All geometries are
transformed to EPSG 4326 (WGS 84) before writing.

``` r
my_vector <- sf::read_sf(
  dsn   = "data/",
  layer = "my_layer"
  ) |>
  dplyr::mutate(
    id_field = as.character(id_field)
  )

# generate attribute metadata template (run once)
try(capeml::write_attributes(my_vector, overwrite = FALSE))

my_vector_desc <- "a description of the vector data entity"

my_vector_SV <- capemlVector::create_vector(
  vector_name   = my_vector,
  description   = my_vector_desc,
  driver        = "GeoJSON",
  overwrite     = TRUE,
  projectNaming = TRUE
)

# my_vector_SV is an EML spatialVector — add it to the EML dataset
```

### workflow: create a spatialVector — output to shapefile (write)

`create_vector_shape()` writes a new shapefile from an sf object in the
R environment. Use this when you want full control over the output
shapefile, including the ability to modify the data before writing. The
shapefile is packaged into a zipped directory.

Unlike `create_vector()`, the output CRS is *not* forced to EPSG 4326 —
pass the EML-compliant `coord_sys` that matches your data. Use
`list_crs()` to look up valid names.

``` r
my_vector <- sf::read_sf(
  dsn   = "data/",
  layer = "my_layer"
  ) |>
  dplyr::mutate(
    id_field = as.character(id_field)
  )

# generate attribute metadata template (run once)
try(capeml::write_attributes(my_vector, overwrite = FALSE))

my_vector_desc <- "a description of the vector data entity"

my_vector_SV <- capemlVector::create_vector_shape(
  vector_name   = my_vector,
  description   = my_vector_desc,
  coord_sys     = "GCS_WGS_1984",
  overwrite     = TRUE,
  projectNaming = TRUE
)
```

### workflow: create a spatialVector — output to shapefile (package existing)

`package_vector_shape()` differs from `create_vector_shape()` in that it
does *not* create a new spatial object. Instead, it harvests the files
that constitute an existing shapefile into a directory that is then
zipped. Use this when it is important that the source data are not read
into R or otherwise altered.

``` r
# generate attribute metadata template by reading the layer into R (run once)
tmp <- sf::st_read(dsn = "data/", layer = "my_layer")
try(capeml::write_attributes(tmp, overwrite = FALSE))
rm(tmp)

my_layer_desc <- "a description of the vector data entity"

my_layer_SV <- capemlVector::package_vector_shape(
  dsn           = "data/",
  layer         = "my_layer",
  description   = my_layer_desc,
  coord_sys     = "GCS_WGS_1984",
  overwrite     = TRUE,
  projectNaming = TRUE
)
```

### workflow: generate geographic coverage from an sf object

`create_geographic_coverage()` generates bounding-coordinate EML
geographic coverage elements from an sf object. A common use is to
generate per-site coverage elements from a table of sampling locations.

``` r
sampling_sites <- tibble::tibble(
  site      = c("North", "South"),
  longitude = c(-112.07, -111.90),
  latitude  = c(33.60,   33.45)
  ) |>
  sf::st_as_sf(
    coords = c("longitude", "latitude"),
    crs    = 4326
  )

geographic_coverage <- split(sampling_sites, sampling_sites$site) |>
  purrr::map(
    ~ capemlVector::create_geographic_coverage(.x, description = .x$site)
  ) |>
  unname()

coverage <- list(
  temporalCoverage  = list(
    rangeOfDates = list(
      beginDate = list(calendarDate = "2019-04-30"),
      endDate   = list(calendarDate = "2020-06-17")
    )
  ),
  geographicCoverage = geographic_coverage
)
```

### helper: list valid EML coordinate reference systems

``` r
# retrieve the full list of EML-compliant CRS names
crs_names <- capemlVector::list_crs()

# find all UTM zone options
crs_names[grepl("UTM", crs_names)]
```
