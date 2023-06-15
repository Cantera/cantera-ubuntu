#/bin/bash

# This is the version used in the name of the branch containing the packaging data,
# e.g. for the branch 'ubuntu22.10-ct3.0', this is '3.0'.
export SHORT_VERSION=3.0

# Ubuntu-compatible version name (insert '~' before a/b tags, e.g. '3.0.0~a5')
export FULL_VERSION=3.0.0~a5

# For releases uploaded to Launchpad, this should be a tag name on the 'main' branch
export BASE_REF="952e465ec"

PPA_TARGET=cantera-team/cantera-unstable
#PPA_TARGET=cantera-team/cantera
