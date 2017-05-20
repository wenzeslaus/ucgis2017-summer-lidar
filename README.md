# ucgis2017-summer-lidar
UCGIS 2017 Summer School: Point Cloud and  Derived Digital Elevation Model Quality Analysis

## Modules to load

module load pdal python/2.7.10 grass

## How to start working with a new dataset

Get tile scheme of LAS files:

    ./tiles_to_scheme.py /path/to/las/files > dataset_tile_scheme.json

Create GRASS GIS location (-e is to exit, i.e. not start, the session):

    grass72 -c EPSG:xxxx ~/grassdata/dataset_crs -e

Create your own mapset (good for multi-user environment):

    grass72 -c ~/grassdata/dataset_crs/username

In GRASS GIS session, import tile scheme:

    v.in.ogr input=dataset_tile_scheme.json output=las_tile_scheme -o

Set a computation region extent according to all tiles and set a course
resolution (align cells to resolution value):

    g.region vector=las_tile_scheme res=10 -a -p

## Getting a new mapset for existing location for UIUC dataset

Get tile scheme of LAS files:

    ./tiles_to_scheme.py /path/to/las/files > dataset_tile_scheme.json

Create your own mapset (good for multi-user environment):

    grass72 -c /projects/.../outputs/grassdata/illinois_ft/username

In GRASS GIS session, import tile scheme:

    v.in.ogr input=uiuc_las_tile_scheme.json output=las_tile_scheme -o

Set a computation region extent according to all tiles and set a course
resolution (align cells to resolution value):

    g.region vector=las_tile_scheme res=10 -a -p
 
 
 ## Notes on qsub.sh 
 - View `pmf_pipe.json` for pipeline specification
 - View `pmf` directory for output on UIUC data
 - Next step: Parallelization on `pdal pipeline`, application to larger dataset
