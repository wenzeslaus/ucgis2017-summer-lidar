#!/usr/bin/env python

# Copyright (C) 2017 Vaclav Petras
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Author: Vaclav Petras


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
    try:
        text = subprocess.check_output(["pdal", "info", "--metadata", lasfile])
    except subprocess.CalledProcessError as err:
        print("PDAL failed on file %s: %s" % (lasfile, err), file=sys.stderr)
        continue
    meta = json.loads(text)
    meta = meta['metadata']
    meta['filename'] = lasfile
    geojson += feature % meta

geojson += """]}"""

print(geojson)
