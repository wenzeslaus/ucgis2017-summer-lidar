#!/bin/bash

# this runs in GRASS only (in session or using --exec)
# assumes after_ferry_classified_10121256 vector
# with building_id column which is NULL when outside of ground truth footprints
# and class_building_cat column which is NULL when outside of identified
# footprints (i.e. it is NULL when point is not a classified as building)

POINTS=classified
TILE=tile

TP=`db.select "SELECT count(cat) FROM $POINTS WHERE true_building_id IS NOT NULL AND class_building_id IS NOT NULL" -c`
FP=`db.select "SELECT count(cat) FROM $POINTS WHERE true_building_id IS NULL AND class_building_id IS NOT NULL" -c`
AL=`db.select "SELECT count(cat) FROM $POINTS WHERE class_building_id IS NOT NULL" -c`

v.db.addcolumn map=$TILE columns="TP INTEGER,FP INTEGER,AL INTEGER"
v.db.update $TILE column=TP value=$TP
v.db.update $TILE column=FP value=$FP
v.db.update $TILE column=AL value=$AL
