# Datasets

## MtRainier

Size: 9.1GB

Number of tiles: 4

## Jean-Lafitte

EPSG:26915
NAD83 / UTM zone 15N
http://epsg.io/26915

Size: 14GB

Number of tiles: 125

## UIUC

EPSG:3443
NAD83(HARN) / Illinois East (ftUS)
http://epsg.io/3443

Size: 485MB

Number of tiles: 15

## WhiteSands

EPSG:6342
NAD83(2011) / UTM zone 13N
http://epsg.io/6342

Size: 93GB

Number of tiles: 142

Format: LAS 1.4 (libLAS and thus GRASS GIS cannot read it)

Problematic files:

    USGS_LPC_NM_WhiteSands_2015_13SCS880380_LAS_2017.las (PDAL fails with bad alloc)

## Notes

To obtain the size of the directories use

    du -h /path/to/parent/directory
