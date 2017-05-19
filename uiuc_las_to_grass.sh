#!/bin/bash
#PBS -N ucgis_lidar_group_job
#PBS -S /bin/bash
#PBS -m ae
#PBS -M xxx@xxx.edu
#PBS -l nodes=1:ppn=5
#PBS -l walltime=0:20:00

module load grass
module load parallel

SPACE=/projects/ucgis/OpenProblems/data/CyberGISandGeospatialDataScience/DataQualityAndUncertainty/
DATA=$SPACE/data
GRASSMAPSET=$SPACE/outputs/grassdata/illinois_ft/vpetras

find /UIUC/*.las > uiuc_las_files.txt

parallel --jobs 5 <<EOF
grass72 $GRASSMAPSET --exec r.in.lidar file=uiuc_las_files.txt output=ground class_filter=2
grass72 $GRASSMAPSET --exec r.in.lidar file=uiuc_las_files.txt output=veg_max method=max class_filter=3,4,5
grass72 $GRASSMAPSET --exec r.in.lidar file=uiuc_las_files.txt output=density_ground method=n class=2
grass72 $GRASSMAPSET --exec r.in.lidar file=uiuc_las_files.txt output=density_all method=n
grass72 $GRASSMAPSET --exec r.in.lidar file=uiuc_las_files.txt output=density_veg method=n class_filter=3,4,5
EOF
