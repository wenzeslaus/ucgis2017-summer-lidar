#!/bin/bash
#PBS -N lidar_class
#PBS -e /projects/ucgis/OpenProblems/data/CyberGISandGeospatialDataScience/DataQualityAndUncertainty/scripts/qsub.err
#PBS -o /projects/ucgis/OpenProblems/data/CyberGISandGeospatialDataScience/DataQualityAndUncertainty/scripts/qsub.out
#PBS -S /bin/bash
#PBS -l walltime=1:00:00
#PBS -l nodes=1:ppn=20

module load liblas
module load pdal
module load parallel

base="/projects/ucgis/OpenProblems/data/CyberGISandGeospatialDataScience/DataQualityAndUncertainty"
inDir="$base/data/UIUC"
tmpDir="$base/outputs/tmp"
outDir="$base/outputs/pmf"

if [ ! -d "$tmpDir" ];
then
	mkdir $tmpDir
fi

if [ ! -d $inDir ]; then
	echo "$inDir is not a Valid directory. Exiting."
	exit 1
fi

echo "Reading files from $inDir"

#for file in "${inDir}"/*.las; 
#do
#	echo "$file"
#	outName=${tmpDir}/$(basename "$file")
#	echo "${outName}"
#	las2las -i $file -o $outName --last-return-only
#done

function classify {
	input=${1}
	
	dataDir="$(dirname "$(dirname "$input")")"
	base="$(dirname "$dataDir")"
	tmpDir=$base/outputs/tmp
	echo "Base is $base"
	outDir=$base/outputs/pmf
	tmpName=${tmpDir}/$(basename "$input")
	las2las -i $input -o $tmpName --last-return-only
	pipe=$base/examples/jsonfiles/pmf_pipe.json
	outName=${outDir}/$(basename "$input")
	echo "Classifying $tmpName into $outName"
	pdal pipeline -i $pipe --readers.las.filename="$tmpName" \
		--writers.las.filename=${outName}
	echo "Done"	
}
export -f classify

FILES=${inDir}/*.las
NUM_FILES=`cat $FILE | wc -l`
parallel --max-procs $NUM_FILES 'classify {}' ::: $FILES

#for file in "${tmpDir}"/*.las;
#do
#	pipe=$base/jsonfiles/pmf_pipe.json
#	outName=${outDir}/$(basename "$file")
#	pdal pipeline -i $pipe --readers.las.filename="$file" \
#		--writers.las.filename=${outName}
#done





