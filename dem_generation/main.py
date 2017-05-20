import os
import numpy as np
import pf
import pdb
print "Begining Script"
path="/projects/ucgis/OpenProblems/data/CyberGISandGeospatialDataScience/DataQualityAndUncertainty/"

os.chdir(path)
inlas_input=raw_input("Provide directory and .las filename (ex: data/UIUC/10101248.las): ")
#pdb.set_trace()
inlas=os.path.join(path, inlas_input)
injson=os.path.join(path, "jsonfiles/reprojection.json")
outputlas=os.path.join(path, "outputs/jamatney/1_repro.las")
print "running pf.reprojection ...."
pf.reprojection(inlas,injson,outputlas)

inlas=os.path.join(path, "outputs/jamatney/1_repro.las")
injson=os.path.join(path, "jsonfiles/radius_noiseremove.json")
outputlas=os.path.join(path, "outputs/jamatney/1_r_remove.las")
print "running pf.radius_noiseremove ...."
pf.radius_noiseremove(inlas,injson,outputlas)

inlas=os.path.join(path, "outputs/jamatney/1_r_remove.las")
injson=os.path.join(path, "jsonfiles/statistic_noiseremove.json")
outputlas=os.path.join(path, "outputs/jamatney/1_s_remove.las")
print "running pf.statistic_noiseremove ...."
pf.statistic_noiseremove(inlas,injson,outputlas)

inlas=os.path.join(path, "outputs/jamatney/1_s_remove.las")
injson=os.path.join(path, "jsonfiles/class_extraction.json")
outputlas=os.path.join(path, "outputs/jamatney/ground_class.las")
code=2
print "running pf.class_extraction ...."
pf.class_extraction(inlas,injson,outputlas,code)

inlas=os.path.join(path, "outputs/jamatney/ground_class.las")
injson=os.path.join(path, "jsonfiles/dem_generation.json")
outputtif=os.path.join(path, "outputs/jamatney/1_dem.tif")
print "running pf.dem_generation ...."
pf.dem_generation(inlas,injson,outputtif)

