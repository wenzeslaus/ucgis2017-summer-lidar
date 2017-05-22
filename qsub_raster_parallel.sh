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
#PBS -l walltime=0:05:00

module load pdal
module load parallel
module load liblas

UCGIS_DIR=/projects/ucgis/OpenProblems/data/CyberGISandGeospatialDataScience/DataQualityAndUncertainty
INPUT_DIR=$UCGIS_DIR/data/UIUC/
TMP_DIR=$UCGIS_DIR/outputs/tmp/

export PIPELINE=$HOME/scripts/ucgis2017-summer-lidar/template.json

if [ ! -d $TMP_DIR ];
then
	mkdir $TMP_DIR
fi

cd $TMP_DIR

#lasfiles = $inputDir/*.las

#parallel [options] [command [arguments]] < list_of_arguments
parallel 'pdal pipeline $PIPELINE --readers.las.filename="{}" --writers.gdal.filename="{.}.tif"' ::: $INPUT_DIR/*.las

#for file in "$inputDir"/*.las;
#do
#	newFile=${file%%.*}
#	out=$tmpDir/$(basename "$newFile").tif
#	echo "IN $file | OUT $out"
#	pdal pipeline -i $json --readers.las.filename="$file" --writers.gdal.filename="$out"

#done


