#!/bin/bash

# this runs in GRASS only (in session or using --exec)
# assumes existence of tiling scheme vector
# with column which contains the tile ID which
# is the parameter

if [ -z "$1" ]
then
    >&2 echo "No argument supplied"
    >&2 echo "Usage:"
    >&2 echo "  $0 input.las"
    exit 1
fi

TILE_ID=${1}
TILE_ID_COLUMN=name
TILES=las_tile_scheme
TILE=tile

v.extract in=$TILES out=$TILE where="$TILE_ID_COLUMN LIKE '%$TILE_ID%'"
g.region vector=$TILE res=9
