#/bin/bash

# This is the version used in the name of the branch containing the packaging data,
# e.g. for the branch 'ubuntu22.10-ct3.0', this is '3.0'.
export SHORT_VERSION=3.0

# Ubuntu-compatible version name (insert '~' before a/b tags, e.g. '3.0.0~a5')
export FULL_VERSION=3.0.0~b1

# For releases uploaded to Launchpad, this should be an "upstream" tag name, e.g. v3.0.0b1
export BASE_REF=v3.0.0b1

PPA_TARGET=cantera-team/cantera-unstable
#PPA_TARGET=cantera-team/cantera
