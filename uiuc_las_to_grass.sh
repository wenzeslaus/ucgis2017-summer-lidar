#!/bin/bash
#PBS -N ucgis_lidar_group_job
#PBS -S /bin/bash
#PBS -m ae
#PBS -M xxx@xxx.edu
#PBS -l nodes=1:ppn=1
#PBS -l walltime=0:20:00

module load grass

find /projects/ucgis/OpenProblems/data/CyberGISandGeospatialDataScience/DataQualityAndUncertainty/data/UIUC/*.las > uiuc_las_files.txt
grass72 ~/grassdata/illinois_east_ft/PERMANENT --exec r.in.lidar file=uiuc_las_files.txt output=ground class=2
