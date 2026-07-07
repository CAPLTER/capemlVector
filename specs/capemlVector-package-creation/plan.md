# Implementation Plan — `capemlVector` Package Extraction

Derived from: `specs/capemlVector-package-creation/spec.md`

---

## Phase 1 — Scaffold `capemlVector` package structure

- [x] 1.1 Create `DESCRIPTION`
- [x] 1.2 Create `R/` directory
- [x] 1.3 Create `tests/testthat/` and `tests/testthat.R`
- [x] 1.4 Create `capemlVector.Rproj`
- [x] 1.5 Create `.Rbuildignore`

## Phase 2 — Migrate functions into `capemlVector`

- [x] 2.1 `create_vector.R` — update `@examples` namespace
- [x] 2.2 `create_vector_shape.R` — update `@examples` namespace
- [x] 2.3 `package_vector_shape.R` — update `@examples` namespace
- [x] 2.4 `helper_list_crs.R`
- [x] 2.5 `create_geographic_coverage.R` from capeml — update namespace
- [x] 2.6 `devtools::document()` — confirm NAMESPACE and man/
- [x] 2.7 `devtools::check()` — 0 errors, 0 warnings

## Phase 3 — Write tests for `capemlVector`

- [x] 3.1 `helper-spatial_fixtures.R`
- [x] 3.2 `test-list_crs.R`
- [x] 3.3 `test-create_geographic_coverage.R`
- [x] 3.4 `test-create_vector.R`
- [x] 3.5 `test-create_vector_shape.R`
- [x] 3.6 `test-package_vector_shape.R`
- [x] 3.7 `devtools::test()` — all pass

## Phase 4 — README and documentation

- [ ] 4.1 Author `README.Rmd`
- [ ] 4.2 Knit to `README.md`
- [ ] 4.3 Create `_pkgdown.yml`
- [ ] 4.4 `pkgdown::build_site()`

## Phase 5 — Clean up `capemlGIS`

- [x] 5.1 Delete `R/create_vector.R`, `create_vector_shape.R`, `package_vector_shape.R`, `helper_list_crs.R`
- [x] 5.2 Delete `R/create_spatialVector.R`, `R/get_emlProjection.R`
- [x] 5.3 Delete `R/emlCoordSystems-data.R` and `data/emlCoordSystems.rda`
- [x] 5.4 Remove `sf` from `DESCRIPTION Imports`
- [x] 5.5 `devtools::document()` — raster-only NAMESPACE
- [ ] 5.6 Update `README.Rmd`/`README.md` — raster-only scope + cross-link
- [x] 5.7 `devtools::check()` — 0 errors, 0 warnings
- [ ] 5.8 `pkgdown::build_site()`

## Phase 6 — Update `capeml`

- [x] 6.1 Replace `create_geographic_coverage.R` with deprecated stub
- [x] 6.2 Remove `sf` from Imports; add `capemlVector` to Suggests + Remotes
- [x] 6.3 `devtools::document()`
- [ ] 6.4 Update `README.Rmd`/`README.md`
- [x] 6.5 `devtools::check()` — 0 errors, 0 warnings
- [ ] 6.6 `pkgdown::build_site()`

## Phase 7 — Cross-package verification

- [ ] 7.1 Fresh session: `library(capemlVector)` — no raster/terra
- [ ] 7.2 Fresh session: `library(capemlGIS)` — no sf
- [ ] 7.3 Fresh session: `library(capeml)` — no sf
- [ ] 7.4 `capeml::create_geographic_coverage()` emits correct deprecation error
- [ ] 7.5 `capemlVector::create_geographic_coverage()` returns correct structure
- [ ] 7.6 `devtools::check()` all three — 0 errors, 0 warnings
- [ ] 7.7 All spec success criteria verified
