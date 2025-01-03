create table A6_LRS (
    GEOM SDO_GEOMETRY
);

INSERT INTO A6_LRS 
SELECT SDO_LRS.CONVERT_TO_LRS_GEOM(SAR.GEOM)
FROM STREETS_AND_RAILROADS SAR, MAJOR_CITIES MC
WHERE SDO_RELATE(
    SAR.GEOM, SDO_GEOM.SDO_BUFFER(MC.GEOM, 10, 1, 'unit=km'),
    'mask=anyinteract') = 'TRUE' AND MC.CITY_NAME = 'Koszalin';
    
SELECT SDO_LRS.GEOM_SEGMENT_LENGTH(GEOM) / 1000, ST_LINESTRING(GEOM).ST_NUMPOINTS()
FROM A6_LRS;

UPDATE A6_LRS
SET GEOM = SDO_LRS.CONVERT_TO_LRS_GEOM(GEOM, 0, 276.681);

INSERT INTO USER_SDO_GEOM_METADATA
VALUES ('A6_LRS','GEOM',
MDSYS.SDO_DIM_ARRAY(
 MDSYS.SDO_DIM_ELEMENT('X', 12.603676, 26.369824, 1),
 MDSYS.SDO_DIM_ELEMENT('Y', 45.8464, 58.0213, 1),
 MDSYS.SDO_DIM_ELEMENT('M', 0, 300, 1) ),
 8307);
 
CREATE INDEX A6_LRS_IDX ON A6_LRS(GEOM) INDEXTYPE IS MDSYS.SPATIAL_INDEX_V2;
--2.


SELECT SDO_LRS.VALID_MEASURE(GEOM, 500)
FROM A6_LRS;

SELECT SDO_LRS.GEOM_SEGMENT_END_PT(GEOM)
FROM A6_LRS;

SELECT SDO_LRS.LOCATE_PT(GEOM, 150, 0) KM150
FROM A6_LRS;

SELECT SDO_LRS.CLIP_GEOM_SEGMENT(GEOM, 120, 160) CLIPED from A6_LRS;

SELECT SDO_LRS.PROJECT_PT(A6.GEOM, C.GEOM) 
FROM A6_LRS A6, MAJOR_CITIES C where C.CITY_NAME = 'Slupsk';

SELECT SDO_LRS.GEOM_SEGMENT_LENGTH(SDO_LRS.CLIP_GEOM_SEGMENT(GEOM, 50, 200, 0))
FROM A6_LRS;
