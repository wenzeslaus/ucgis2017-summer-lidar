#!/bin/sh

### Set the job name
#PBS -N lidar
### Use the bourne shell
#PBS -S /bin/bash
### To send email when the job is completed: be --- before execution ae 
### --- after execution
#PBS -m ae PBS -M hathcock@gri.msstate.edu
### Specify the number of cpus for your job.
#PBS -l nodes=1:ppn=20
### Tell PBS the anticipated run-time for your job, where 
### walltime=HH:MM:SS
#PBS -l walltime=0:05:00

module load pdal
module load parallel
module load liblas

cd $HOME/UIUC/
tmpDir=$HOME/UIUC/tmp

if [ ! -d $tmpDir ];
then
	mkdir $tmpDir
fi
inputDir="/home/leeh/UIUC"
json="template.json"
#lasfiles = $inputDir/*.las

#parallel [options] [command [arguments]] < list_of_arguments
parallel 'pdal pipeline template.json --readers.las.filename="{}" --writers.gdal.filename="{.}.tif"' ::: *.las

#for file in "$inputDir"/*.las;
#do
#	newFile=${file%%.*}
#	out=$tmpDir/$(basename "$newFile").tif
#	echo "IN $file | OUT $out"
#	pdal pipeline -i $json --readers.las.filename="$file" --writers.gdal.filename="$out"

#done


