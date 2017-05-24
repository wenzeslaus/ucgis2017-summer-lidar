#!/bin/bash
#PBS -N ucgis_lidar
#PBS -S /bin/bash
#PBS -m ae
#PBS -M vpetras@ncsu.edu
#PBS -l nodes=1:ppn=8
#PBS -l walltime=0:30:00

module load grass
module load parallel

SPACE=/projects/ucgis/OpenProblems/data/CyberGISandGeospatialDataScience/DataQualityAndUncertainty/
DATA=$SPACE/outputs/ny
GRASSMAPSET=$SPACE/outputs/grassdata/ny/PERMANENT

LAS_FILE_LIST=las_file_list.txt
JOBS=8

find $DATA/*.las > $LAS_FILE_LIST

export GRASS_OVERWRITE=1

grass72 $GRASSMAPSET --exec g.region vector=las_tile_scheme res=10 -a

grass72 $GRASSMAPSET -f --exec parallel --jobs $JOBS <<EOF
r.in.lidar file=$LAS_FILE_LIST output=all_max_10m method=max
r.in.lidar file=$LAS_FILE_LIST output=last_max_10m method=max return_filter=last
r.in.lidar file=$LAS_FILE_LIST output=mid_max_10m method=max return_filter=mid
r.in.lidar file=$LAS_FILE_LIST output=ground_10m class_filter=2
r.in.lidar file=$LAS_FILE_LIST output=veg_max_10m method=max class_filter=3,4,5
r.in.lidar file=$LAS_FILE_LIST output=density_ground_10m method=n class=2
r.in.lidar file=$LAS_FILE_LIST output=density_all_10m method=n
r.in.lidar file=$LAS_FILE_LIST output=density_veg_10m method=n class_filter=3,4,5
EOF

grass72 $GRASSMAPSET --exec g.region vector=las_tile_scheme res=2 -a

grass72 $GRASSMAPSET -f --exec parallel --jobs $JOBS <<EOF
r.in.lidar file=$LAS_FILE_LIST output=all_max_2m method=max
r.in.lidar file=$LAS_FILE_LIST output=last_max_2m method=max return_filter=last
r.in.lidar file=$LAS_FILE_LIST output=mid_max_2m method=max return_filter=mid
r.in.lidar file=$LAS_FILE_LIST output=ground_2m class_filter=2
r.in.lidar file=$LAS_FILE_LIST output=veg_max_2m method=max class_filter=3,4,5
r.in.lidar file=$LAS_FILE_LIST output=density_ground_2m method=n class=2
r.in.lidar file=$LAS_FILE_LIST output=density_all_2m method=n
r.in.lidar file=$LAS_FILE_LIST output=density_veg_2m method=n class_filter=3,4,5
EOF
