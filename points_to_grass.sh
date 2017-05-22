#!/bin/bash

# this runs in GRASS only (in session or using --exec)
# assumes after_ferry_classified_10121256 raster
# which is height of points so far classified as buildings

# this needs to run in separate mapsets or needs the following command
# to be executed:
# db.connect driver=sqlite database='$GISDBASE/$LOCATION_NAME/$MAPSET/vector/$MAP/sqlite.db'

# using CSV because that can be also loaded easily into SQLite database
# without GRASS GIS (which actually loads the attributes to SQLite
# database, so LAS can be used eventually)

v.in.ascii input=after_ferry_classified_10121256.txt output=after_ferry_classified_10121256 sep=comma skip=1 z=3
