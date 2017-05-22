#!/bin/bash

# this runs in GRASS only (in session or using --exec)

v.patch in=`g.list mapset='*' type=vector pattern="area" -m sep=comma` out=areas

v.patch in=`g.list mapset='*' type=vector pattern="tile" -m sep=comma` out=tiles -e

v.db.addcolumn tiles columns="BF DOUBLE, precison DOUBLE"
v.db.update map=tiles column=BF query_column="FP / (1.0 * TP + FP)"
v.db.update map=tiles column=precison query_column="TP / (1.0 * TP + FP)"

v.colors map=tiles use=attr column=precision color=viridis
