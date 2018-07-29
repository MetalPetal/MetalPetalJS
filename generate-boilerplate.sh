#!/bin/bash

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

SOURCE_DIR="$BASEDIR/MetalPetalJS/"

cd "$BASEDIR/BoilerplateGenerator"

swift run BoilerplateGenerator $SOURCE_DIR
