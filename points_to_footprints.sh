#!/bin/bash

# this runs in GRASS only (in session or using --exec)
# assumes after_ferry_classified_10121256 raster
# which is height of points so far classified as buildings

# it also expect the computational region to be set to desired area

# required module from GRASS GIS Addons repository
g.extension r.area

INPUT=classified

r.mapcalc "presence = if(isnull($INPUT), null(), 1)"

r.clump presence out=clump

r.area in=clump out=area lesser=20

r.colors area color=random

r.to.vect in=area out=area type=area -s
