#!/bin/bash

# this runs in GRASS only (in session or using --exec)
# assumes after_ferry_classified_10121256 vector
# with building_id column which is NULL when outside of ground truth footprints
# and class_building_cat column which is NULL when outside of identified
# footprints (i.e. it is NULL when point is not a classified as building)

POINTS=classified
TILE=tile

TP=`db.select "SELECT count(cat) FROM $POINTS WHERE building_id IS NOT NULL AND class_building_cat IS NOT NULL" -c`
FP=`db.select "SELECT count(cat) FROM $POINTS WHERE building_id IS NULL AND class_building_cat IS NOT NULL" -c`
AL=`db.select "SELECT count(cat) FROM $POINTS WHERE class_building_cat IS NOT NULL" -c`

v.db.addcolumn $POINT columns="TP INTEGER,FP INTEGER,ALL INTEGER"
v.db.update $POINT column=TP value=$TP
v.db.update $POINT column=FP value=$FP
v.db.update $POINT column=ALL value=$AL
