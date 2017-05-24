#!/bin/bash

input=/projects/ucgis/OpenProblems/data/CyberGISandGeospatialDataScience/DataQualityAndUncertainty/data/UIUC/10121256.las
pipeline=/projects/ucgis/OpenProblems/data/CyberGISandGeospatialDataScience/DataQualityAndUncertainty/examples/jsonfiles/pmf_pipe.json

las2las -i $input -o tmp1.las --last-return-only && \
    pdal pipeline -i $pipeline --readers.las.filename=tmp1.las --writers.las.filename=tmp2.las --filters.pmf.initial_distance=1.0 && \
    r.in.lidar input=tmp12.las output=buildings_test -e res=1 -n --o
