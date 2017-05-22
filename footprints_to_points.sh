#!/bin/bash

# this runs in GRASS only (in session or using --exec)
# assumes points vector, true and detected building footprints

POINTS=classified
TRUE_FOOTPRINTS=true_footprints
DETECTED_FOOTPRINTS=area

TRUE_FOOTPRINT_ID_COL=building_id
DETECTED_FOOTPRINT_ID_COL=class_building_cat

v.db.addcolumn $POINTS column="$DETECTED_FOOTPRINT_ID_COL INTEGER"
v.what.vect map=$POINTS col=$DETECTED_FOOTPRINT_ID_COL query_map=$TRUE_FOOTPRINTS query_column=objectid

v.db.addcolumn $POINTS column="$DETECTED_FOOTPRINT_ID_COL INTEGER"
v.what.vect map=$POINTS col=$DETECTED_FOOTPRINT_ID_COL query_map=$DETECTED_FOOTPRINTS query_column=cat
