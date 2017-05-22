#!/bin/sh

# job name
#PBS -N ucgis_lidar
# use the bourne shell
#PBS -S /bin/bash
# send email after execution
#PBS -m ae PBS -M vpetras@ncsu.edu
# number of cpus
#PBS -l nodes=1:ppn=20
# anticipated run-time
#PBS -l walltime=1:00:00

module load pdal
module load parallel
module load liblas

UCGIS_DIR=/projects/ucgis/OpenProblems/data/CyberGISandGeospatialDataScience/DataQualityAndUncertainty
INPUT_DIR=$UCGIS_DIR/data/UIUC/
TMP_DIR=$UCGIS_DIR/outputs/tmp2/

export PIPELINE=$HOME/scripts/ucgis2017-summer-lidar/ferry_pmf_pile.json

if [ ! -d $TMP_DIR ];
then
    mkdir $TMP_DIR
fi

cd $TMP_DIR

#lasfiles = $inputDir/*.las

parallel 'pdal pipeline $PIPELINE --readers.las.filename="{}" --writers.las.filename="{/.}.las"' ::: $INPUT_DIR/*.las
