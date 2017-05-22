#!/bin/bash

# this runs in GRASS only (in session or using --exec)
# assumes after_ferry_classified_10121256 vector

v.db.addcolumn after_ferry_classified_10121256 column="building_id INTEGER"
v.what.vect map=after_ferry_classified_10121256 col=building_id query_map=OGRGeoJSON query_column=objectid

v.db.addcolumn after_ferry_classified_10121256 column="class_building_cat INTEGER"
v.what.vect map=after_ferry_classified_10121256 col=class_building_cat query_map=area query_column=cat
