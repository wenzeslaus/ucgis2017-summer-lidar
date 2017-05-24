#!/bin/bash

# this runs in GRASS only (in session or using --exec)
# expects mapsets with maps with same names

MAPSET=${1}

if [ -z "$1" ]
then
    >&2 echo "No argument supplied"
    >&2 echo "Usage:"
    >&2 echo "  $0 mapset_pattern"
    #exit 1
    MAPSET="tmp_"
fi

v.patch in=`g.list mapset='*' type=vector pattern="area" -m sep=newline | grep $MAPSET | paste -s -d ','` out=areas

v.patch in=`g.list mapset='*' type=vector pattern="tile" -m sep=newline | grep $MAPSET | paste -s -d ','` out=tiles -e

v.db.addcolumn tiles columns="BF DOUBLE, precision DOUBLE"
v.db.update map=tiles column=BF query_column="FP / (1.0 * TP + FP)"
v.db.update map=tiles column=precision query_column="TP / (1.0 * TP + FP)"

g.copy vect=tiles,tiles_precision_colortable
v.colors map=tiles_precision_colortable use=attr column=precision color=viridis

v.db.select tiles sep=tab columns=cat,TP,FP,precision > precision_table.txt

echo "Precision:" > precision_agg.txt
db.select sql="SELECT SUM(TP) / (1.0 * SUM(TP) + SUM(FP)) FROM tiles WHERE TP <> 0 AND name NOT LIKE '%10141256%'" -c >> precision_agg.txt
echo "Branch factor:" >> precision_agg.txt
db.select sql="SELECT SUM(FP) / (1.0 * SUM(TP) + SUM(FP)) FROM tiles WHERE TP <> 0 AND name NOT LIKE '%10141256%'" -c >> precision_agg.txt
