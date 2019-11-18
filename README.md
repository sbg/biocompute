# biocompute

[![Travis build status](https://travis-ci.org/sbg/biocompute.svg?branch=master)](https://travis-ci.org/sbg/biocompute)
[![AppVeyor build status](https://ci.appveyor.com/api/projects/status/2owpw6m61bnihetf/branch/master?svg=true)](https://ci.appveyor.com/project/nanxstats/biocompute)

Seven Bridges implementation of the BioCompute Object (BCO) specification. Offers the capabilities to compose, validate, and convert BioCompute Objects with R.

Users can encode information in data frames, and compose BioCompute Objects from the domains defined by the standard. A checksum validator and a JSON schema validator are provided. This package also supports exporting BioCompute Objects as JSON, PDF, HTML, or Word documents, and exporting to cloud-based platforms.

Check out the [introduction vignette](https://sbg.github.io/biocompute/articles/intro.html) or the [case study vignette](https://sbg.github.io/biocompute/articles/case-study.html) to get started.

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

## Copyright

© 2019 Seven Bridges Genomics, Inc. All rights reserved.

This project is licensed under the GNU Affero General Public License v3.
