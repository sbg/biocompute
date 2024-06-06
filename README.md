# biocompute

[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental-1)
[![CRAN Version](https://www.r-pkg.org/badges/version/biocompute)](https://cran.r-project.org/package=biocompute)
[![Travis build status](https://app.travis-ci.com/sbg/biocompute.svg?branch=master)](https://app.travis-ci.com/sbg/biocompute)
[![Downloads from the RStudio CRAN mirror](https://cranlogs.r-pkg.org/badges/grand-total/biocompute)](https://cran.r-project.org/package=biocompute)

Seven Bridges implementation of the BioCompute Object (BCO) specification. Offers the capabilities to compose, validate, and convert BioCompute Objects with R.

Users can encode information in data frames, and compose BioCompute Objects (BCO) from the domains defined by the standard. A checksum validator and a JSON schema validator are provided. This package also supports exporting BioCompute Objects as JSON, PDF, HTML, or Word documents, and exporting to cloud-based platforms.

Check out the [introduction vignette](https://sbg.github.io/biocompute/articles/intro.html) or the [case study vignette](https://sbg.github.io/biocompute/articles/case-study.html) to get started.

To see the library used in a real application, refer to the [BCO App repository](https://github.com/sbg/bco-app).

## Installation

To download and install `biocompute` from CRAN:

```r
install.packages("biocompute")
```

Or try the development version on GitHub:

```r
# install.packages("remotes")
remotes::install_github("sbg/biocompute")
```

Note: the code in this repository is the most up to date, and is not available for install in CRAN. If you are looking for a library that is more consistent with the BCO standard, it is recommended you install the development version from this repository.

## Copyright

© 2021 Seven Bridges Genomics, Inc. All rights reserved.

This project is licensed under the GNU Affero General Public License v3.
