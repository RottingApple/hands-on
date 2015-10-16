# Session 3 - PostGIS

## Setup

````
docker run -p 5432:5432 fiitpdt/postgis
````

Phew, no volume mapping neccessary this time. The rest is as usual. You can
safely ignore errors about extension being already present and there are some
constraint validation failures, but don't worry about them.

Login: postgres
Database: gis
Password: none, leave blank

Inside the database, you'll find Open Street Map data for a large portion of
Bratislava. More precisely, this envelope:

![Map envelope](map_large.png)

SRID: WGS 84

## Outline

- spatial reference system & projections
- mercator game
- basic GIS data types
- drawing maps with Mapbox Studio Classic
- styling maps with CartoCSS in Mapbox Studio Classic
- quick overview of some basic GIS functions:
  - st_touches
  - st_intersects
  - st_distance
  - st_dwithin
  - st_contains
  - st_area

## SQL tricks you might find useful

- cross joins

  You'll be using cross joins (cartesian joins) a lot, because often, there is
  no column to join on. The regular join syntax requires a `ON` clausule, so
  something like the followint is a syntax error.

  `SELECT * FROM planet_osm_lines l JOIN planet_osm_polygons p WHERE p.name =
  'Karlova Ves'

  instead, you need to do

  `SELECT * FROM planet_osm_lines l **CROSS** JOIN planet_osm_polygons p WHERE
  p.name = 'Karlova Ves'

- `with` clausule

  When you need to use a subselect, the query can often get very hairy and
  unreadable. Alternatively, you can first set up all subqueries and then just
  reference them, e.g.:

  `WITH leisure AS (
    SELECT * FROM planet_osm_polygon p
    WHERE leisure IS NOT NULL
  )
  SELECT SUM(st_area(way)) FROM leisure`

  TODO: better example

## Homework

1. How far (air distance) is FIIT STU from the Bratislava main train station?
   The query should output the distance in meters without any further
   modification.

   Hint: notice the difference between gemoetry and geography types in this
   case.

2. Which areas (districts, cities, mountains) are direct neighbours with
   'Karlova Ves'?

3. Which streets connect with 'Molecova' street?

4. Find names of all streets in 'Dlhé diely' district.

5. What percentage of area of 'Dlhé diely' is available for leisure? (such as
   parks, tennis courts, etc.)

6. In which restaurants can you enjoy a view of the Danube river? Let's say
   that the air distance must be less than 300 meters.

## Recommended reading

- [list of OSM tags](http://wiki.openstreetmap.org/wiki/Category:En_tag_descriptions)
