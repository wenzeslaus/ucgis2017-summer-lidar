# ucgis2017-summer-lidar
UCGIS 2017 Summer School: Point Cloud and  Derived Digital Elevation Model Quality Analysis


## How to start working with a new dataset

Get tile scheme of LAS files:

    ./tiles_to_scheme.py /path/to/las/files > dataset_tile_scheme.json

Create GRASS GIS location:

    grass72 -c EPSG:xxxx ~/grassdata/dataset_crs

In GRASS GIS session, import tile scheme:

    v.in.ogr input=whitesands_tile_scheme.json output=las_tile_scheme -o

Set a computation region extent according to all tiles and set a course
resolution (align cells to resolution value):

    g.region vector=las_tile_scheme res=10 -a -p
