# biocompute 1.0.6

## Test environments

- Local macOS install, R 4.1.1
- Ubuntu 20.04.1 LTS (on R-hub), R 4.1.1
- win-builder (release, devel, and oldrelease)

## R CMD check results

There were no ERRORs or WARNINGs.
# biocompute 1.0.3

## Test environments

- Local macOS install, R 3.6.1
- Ubuntu 16.04.6 LTS (on Travis-CI), R 3.6.1
- win-builder (release, devel, and oldrelease)

## R CMD check results

There were no ERRORs or WARNINGs.

## License file

Removed the redundant copy of the full AGPL-3 license file as requested.

# biocompute 1.0.2

## Test environments

- Local macOS install, R 3.6.1
- Ubuntu 16.04.6 LTS (on Travis-CI), R 3.6.1
- win-builder (release, devel, and oldrelease)

## R CMD check results

There were no ERRORs or WARNINGs.

## Explanation for the stylized names

A 'BioCompute Object' ('BCO') is an instance of the 'BioCompute' standard (https://en.wikipedia.org/wiki/BioCompute_Object). To follow the convention, we stylized it as 'BioCompute Object' instead of 'BioCompute object' in the Description text.

## Single quotes

Added single quotes to the Description section as suggested ('Word').

## Use \donttest

Replaced \dontrun{} by \donttest{} in the Rd files as suggested.

# biocompute 1.0.1

## Test environments

- Local macOS install, R 3.6.1
- Ubuntu 16.04.6 LTS (on Travis-CI), R 3.6.1
- win-builder (release, devel, and oldrelease)

## R CMD check results

There were no ERRORs or WARNINGs.

## Single quotes in title and description

Unnecessary quotes have been removed from the title and description.

## Reference format

The reference format has been fixed in description text.

## Missing RD tags

The `\value` tag has been added to exported functions to explain the return results.
