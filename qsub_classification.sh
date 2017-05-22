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
#PBS -l walltime=0:10:00

module load pdal
module load parallel
module load liblas
module load grass

UCGIS_DIR=/projects/ucgis/OpenProblems/data/CyberGISandGeospatialDataScience/DataQualityAndUncertainty
INPUT_DIR=$UCGIS_DIR/data/UIUC/
TMP_DIR=$UCGIS_DIR/outputs/tmp2/

export GRASS_LOCATION=$UCGIS_DIR/outputs/grassdata/illinois_ft

export SCRIPTS_DIR=$HOME/scripts/ucgis2017-summer-lidar
export PIPELINE=$SCRIPTS_DIR/ferry_pmf_pile.json

# we overwrite the other data, so we overwrite also GRASS GIS data
export GRASS_OVERWRITE=1

if [ ! -d $TMP_DIR ];
then
    mkdir $TMP_DIR
fi

cd $TMP_DIR

#lasfiles = $inputDir/*.las

function classify {
    INPUT_POINTS=${1}
    BASE_POINTS=`basename ${1} .las`
    OUTPUT_POINTS="$BASE_POINTS.las"
    TMP_POINTS="last_only_$BASE_POINTS.las"
    TMP_MAPSET="tmp_$BASE_POINTS"

    las2las -i $INPUT_POINTS -o $TMP_POINTS --last-return-only
    pdal pipeline $PIPELINE --readers.las.filename="$TMP_POINTS" --writers.las.filename="$OUTPUT_POINTS"
    grass72 -e -c $GRASS_LOCATION/$TMP_MAPSET
    grass72 $GRASS_LOCATION/$TMP_MAPSET --exec $SCRIPTS_DIR/set_region.sh $BASE_POINTS
    grass72 $GRASS_LOCATION/$TMP_MAPSET --exec $SCRIPTS_DIR/points_to_grass.sh $OUTPUT_POINTS
    grass72 $GRASS_LOCATION/$TMP_MAPSET --exec $SCRIPTS_DIR/points_to_footprints.sh
    grass72 $GRASS_LOCATION/$TMP_MAPSET --exec $SCRIPTS_DIR/footprints_to_points.sh
    grass72 $GRASS_LOCATION/$TMP_MAPSET --exec $SCRIPTS_DIR/getting_tp_and_fp.sh
}
export -f classify

parallel 'classify {}' ::: $INPUT_DIR/*.las

AGG_MAPSET=agg
grass72 -e -c $GRASS_LOCATION/$AGG_MAPSET
grass72 $GRASS_LOCATION/$AGG_MAPSET --exec $SCRIPTS_DIR/patch_results.sh
