#!/bin/bash
#PBS -N ucgis_lidar
#PBS -S /bin/bash
#PBS -m ae
#PBS -M vpetras@ncsu.edu
#PBS -l nodes=2:ppn=20
#PBS -l walltime=0:30:00

module load parallel

export OUTPUT=/projects/ucgis/OpenProblems/data/CyberGISandGeospatialDataScience/DataQualityAndUncertainty/outputs/ny
export SCRIPTS_DIR=$HOME/scripts/ucgis2017-summer-lidar

parallel < $SCRIPTS_DIR/wget_ny.sh
parallel < $SCRIPTS_DIR/uzip_ny.sh
parallel < $SCRIPTS_DIR/uzip_las_ny.sh
