#!/bin/bash

# this runs in GRASS only (in session or using --exec)

# this needs to run in separate mapsets or needs the following command
# to be executed:
# db.connect driver=sqlite database='$GISDBASE/$LOCATION_NAME/$MAPSET/vector/$MAP/sqlite.db'


if [ -z "$1" ]
then
    >&2 echo "No argument supplied"
    >&2 echo "Usage:"
    >&2 echo "  $0 input.las"
    exit 1
fi

INPUT=${1}
OUTPUT=classified

# ideally we would set region ahead and not using -e and res
# it would be faster and it would align all the rasters
# but for point-based evaluations it is enough

r.in.lidar input=$INPUT output=classified
v.in.lidar input=$INPUT output=classified
