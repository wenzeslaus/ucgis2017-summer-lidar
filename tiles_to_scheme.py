#!/usr/bin/env python

from __future__ import print_function

import sys
import subprocess
from os import listdir
from os.path import isfile, join
import json

path = sys.argv[1]

lasfiles = [join(path, f) for f in listdir(path)
            if isfile(join(path, f)) and f.endswith(".las")]


geojson = """{
"type": "FeatureCollection",
  "features": [
"""

feature = """{
  "type": "Feature",
  "geometry": {
       "type": "Polygon",
       "coordinates": [
           [
               [%(minx)s, %(miny)s],
               [%(maxx)s, %(miny)s],
               [%(maxx)s, %(maxy)s],
               [%(minx)s, %(maxy)s],
               [%(minx)s, %(miny)s]
           ]
       ]
    },
    "properties": {
        "name": "%(filename)s"
  }
},
"""

for lasfile in lasfiles:
    # check_output requires Python 2.7
    text = subprocess.check_output(["pdal", "info", "--metadata", lasfile])
    meta = json.loads(text)
    meta = meta['metadata']
    meta['filename'] = lasfile
    geojson += feature % meta

geojson += """]}"""

print(geojson)
