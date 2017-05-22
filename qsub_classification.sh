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

function classify {
    INPUT_POINTS=${1}
    BASE_POINTS=`basename .s las ${1}`
    OUTPUT_POINTS="$BASE_POINTS.las"
    TMP_POINTS="last_only_$BASE_POINTS.las"

    las2las -i $INPUT_POINTS -o $TMP_POINTS --last-return-only
    pdal pipeline $PIPELINE --readers.las.filename="$TMP_POINTS" --writers.las.filename="$OUTPUT_POINTS"
}
export -f classify

parallel 'classify {}' ::: $INPUT_DIR/*.las
