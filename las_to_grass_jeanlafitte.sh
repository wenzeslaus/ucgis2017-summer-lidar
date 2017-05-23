#!/bin/bash
#PBS -N ucgis_lidar
#PBS -S /bin/bash
#PBS -m ae
#PBS -M vpetras@ncsu.edu
#PBS -l nodes=1:ppn=5
#PBS -l walltime=0:30:00

module load grass
module load parallel

SPACE=/projects/ucgis/OpenProblems/data/CyberGISandGeospatialDataScience/DataQualityAndUncertainty/
DATA=$SPACE/data/Jean-Lafitte/
GRASSMAPSET=$SPACE/outputs/grassdata/jeanlafitte/PERMANENT

find $DATA/*.las > las_files_jeanlafitte.txt

grass72 $GRASSMAPSET --exec g.region vector=las_tile_scheme res=10

parallel --jobs 5 <<EOF
grass72 $GRASSMAPSET -f --exec r.in.lidar file=las_files_jeanlafitte.txt output=ground_10m class_filter=2
grass72 $GRASSMAPSET -f --exec r.in.lidar file=las_files_jeanlafitte.txt output=veg_max_10m method=max class_filter=3,4,5
grass72 $GRASSMAPSET -f --exec r.in.lidar file=las_files_jeanlafitte.txt output=density_ground_10m method=n class=2
grass72 $GRASSMAPSET -f --exec r.in.lidar file=las_files_jeanlafitte.txt output=density_all_10m method=n
grass72 $GRASSMAPSET -f --exec r.in.lidar file=las_files_jeanlafitte.txt output=density_veg_10m method=n class_filter=3,4,5
EOF

grass72 $GRASSMAPSET --exec g.region vector=las_tile_scheme res=2

parallel --jobs 5 <<EOF
grass72 $GRASSMAPSET -f --exec r.in.lidar file=las_files_jeanlafitte.txt output=ground_2m class_filter=2
grass72 $GRASSMAPSET -f --exec r.in.lidar file=las_files_jeanlafitte.txt output=veg_max_2m method=max class_filter=3,4,5
grass72 $GRASSMAPSET -f --exec r.in.lidar file=las_files_jeanlafitte.txt output=density_ground_2m method=n class=2
grass72 $GRASSMAPSET -f --exec r.in.lidar file=las_files_jeanlafitte.txt output=density_all_2m method=n
grass72 $GRASSMAPSET -f --exec r.in.lidar file=las_files_jeanlafitte.txt output=density_veg_2m method=n class_filter=3,4,5
EOF
