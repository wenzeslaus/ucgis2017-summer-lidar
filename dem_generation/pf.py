import json
import numpy as np
import os
os.chdir("/projects/ucgis/OpenProblems/data/CyberGISandGeospatialDataScience/DataQualityAndUncertainty")
import pdb

def reprojection(inlas,injson,outputlas):
    with open(injson, "r+") as jsonFile:
        data = json.load(jsonFile)
        data['pipeline'][0]["filename"] =inlas
        data['pipeline'][2]["filename"] =outputlas
        jsonFile.seek(0)  # rewind
        jsonFile.write(json.dumps(data))
        jsonFile.truncate()  
        os.system("pdal pipeline "+injson)

def radius_noiseremove(inlas,injson,outputlas):
    with open(injson, "r+") as jsonFile:
        data = json.load(jsonFile)
        data['pipeline'][0] =inlas
        data['pipeline'][2]=outputlas
        jsonFile.seek(0)  # rewind
        jsonFile.write(json.dumps(data))
        jsonFile.truncate()
        os.system('pdal pipeline '+injson)

def statistic_noiseremove(inlas,injson,outputlas):
    with open(injson, "r+") as jsonFile:
        data = json.load(jsonFile)
        data['pipeline'][0] =inlas
        data['pipeline'][2]=outputlas
        jsonFile.seek(0)  # rewind
        jsonFile.write(json.dumps(data))
        jsonFile.truncate()
        os.system('pdal pipeline '+injson)

def class_extraction(inlas,injson,outputlas,code):
    with open(injson, "r+") as jsonFile:
        data = json.load(jsonFile)
        data['pipeline'][0] =inlas
        data['pipeline'][1]["limits"]="Classification["+str(code)+":"+str(code)+"]"           
        data['pipeline'][2]["filename"]=outputlas
        jsonFile.seek(0)  # rewind
        jsonFile.write(json.dumps(data))
        jsonFile.truncate()
        os.system('pdal pipeline '+injson)

def dem_generation(inlas,injson,outputtif):
    with open(injson, "r+") as jsonFile:
        data = json.load(jsonFile)
        data['pipeline'][0]["filename"] =inlas
        data['pipeline'][2]["filename"]=outputtif
        jsonFile.seek(0)  # rewind
        jsonFile.write(json.dumps(data))
        jsonFile.truncate()
        os.system('pdal pipeline '+injson)
    
def las2txt(inlas,injson,outputtxt):
    with open(injson, "r+") as jsonFile:
        data = json.load(jsonFile)
        data['pipeline'][0]['filename'] =inlas
        data['pipeline'][1]['filename']=outputtxt
        jsonFile.seek(0)  # rewind
        jsonFile.write(json.dumps(data))
        jsonFile.truncate()
        os.system('pdal pipeline '+injson)

def crop(inlas,injson,outputlas,extent):
    with open(injson, "r+") as jsonFile:
        data = json.load(jsonFile)
        data['pipeline'][0] =inlas
        data['pipeline'][1]["bounds"] =extent
        data['pipeline'][2]["filename"]=outputlas
        jsonFile.seek(0)  # rewind
        jsonFile.write(json.dumps(data))
        jsonFile.truncate()
        os.system("pdal pipeline "+injson)

def merge(mergelist,injson,outputlas):
       outlas='_'.join(mergelist)
       fil="merge.json"
       with open(fil, "r+") as jsonFile:
          data = json.load(jsonFile)
          tem=list()
          for i in range(len(mergelist)):
             tem=mergelist[i]
             data['pipeline'][i]=tem
          if i<3:
             tt=0
             for f in range((i+1),4):
                tt=tt+1
                if tt==1:
                   conttt=f
                del data['pipeline'][conttt]
          data['pipeline'][len(mergelist)+1] =outputlas
          jsonFile.seek(0) 
          jsonFile.write(json.dumps(data))
          jsonFile.truncate()
          os.system("pdal pipeline "+fil)
          os.system("rm "+fil)
          os.system("cp mergefilterorigin.json "+fil)


#pdb.set_trace()
#inlas="/home/zeweixu2/summerschool/natural_scene/1.las"
#injson="/home/zeweixu2/summerschool/jsonfiles/reprojection.json"
#outputlas="/home/zeweixu2/summerschool/1_repro.las"
#reprojection(inlas,injson,outputlas)

#inlas="/home/zeweixu2/summerschool/natural_scene/1.las"
#injson="/home/zeweixu2/summerschool/jsonfiles/radius_noiseremove.json"
#outputlas="/home/zeweixu2/summerschool/1_r_remove.las"
#radius_noiseremove(inlas,injson,outputlas)

#inlas="/home/zeweixu2/summerschool/natural_scene/1.las"
#injson="/home/zeweixu2/summerschool/jsonfiles/statistic_noiseremove.json"
#outputlas="/home/zeweixu2/summerschool/1_s_remove.las"
#statistic_noiseremove(inlas,injson,outputlas)

#inlas="/home/zeweixu2/summerschool/natural_scene/1.las"
#injson="/home/zeweixu2/summerschool/jsonfiles/class_extraction.json"
#outputlas="/home/zeweixu2/summerschool/1_class.las"
#code=2
#class_extraction(inlas,injson,outputlas,code)

#inlas="/home/zeweixu2/summerschool/natural_scene/1.las"
#injson="/home/zeweixu2/summerschool/jsonfiles/dem_generation.json"
#outputtif="/home/zeweixu2/summerschool/1_dem.tif"
#dem_generation(inlas,injson,outputtif)

#inlas="/home/zeweixu2/summerschool/natural_scene/1.las"
#injson="/home/zeweixu2/summerschool/jsonfiles/las2txt.json"
#outputtif="/home/zeweixu2/summerschool/1_txt.txt"
#las2txt(inlas,injson,outputtxt)

#inlas="/home/zeweixu2/summerschool/natural_scene/1.las"
#injson="/home/zeweixu2/summerschool/jsonfiles/crop.json"
#outputtif="/home/zeweixu2/summerschool/1_cropped.tif"
#crop(inlas,injson,outputlas,extent)

#inlas="/home/zeweixu2/summerschool/natural_scene/1.las"
#injson="/home/zeweixu2/summerschool/jsonfiles/merge.json"
#outputtif="/home/zeweixu2/summerschool/1_merge.tif"
#merge(mergelist,injson,outputlas)

