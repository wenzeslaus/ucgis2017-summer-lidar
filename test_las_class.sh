#!/bin/bash

input=/projects/ucgis/OpenProblems/data/CyberGISandGeospatialDataScience/DataQualityAndUncertainty/data/UIUC/10121256.las
pipeline=/projects/ucgis/OpenProblems/data/CyberGISandGeospatialDataScience/DataQualityAndUncertainty/examples/jsonfiles/pmf_pipe.json

las2las -i $input -o tmp_10121256.las --last-return-only && \
    pdal pipeline -i $pipeline --readers.las.filename=tmp_10121256.las --writers.las.filename=10121256.las --filters.pmf.initial_distance=1.0 && \
    r.in.lidar input=10121256.las output=buildings_tile_10121256 -e res=9 --o
