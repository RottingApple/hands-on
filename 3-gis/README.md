# Session 3 - PostGIS

## Setup

1. Download [Mapbox Studio Classic](https://www.mapbox.com/mapbox-studio-classic)
2. Download the docker container as usual

````
docker run -p 5432:5432 fiitpdt/postgis
````

Phew, no volume mapping neccessary this time. The rest is as usual. You can
safely ignore errors about extension being already present and there are some
constraint validation failures, but don't worry about them.

| Attribute| Value                  |
|----------|------------------------|
| Login    | postgres               |
| Database | gis                    |
| Password | none, leave blank      |
| Spatial reference system | WGS 84 |

Inside the database, you'll find Open Street Map data for a large portion of
Bratislava. More precisely, this extent:

![Map envelope](map_large.png)

## Outline

1. [Spatial reference system & projections](http://help.arcgis.com/en/sdk/10.0/arcobjects_net/conceptualhelp/index.html#//0001000002mq000000)
2. [Understanding Mercator projection](http://www.wired.com/2013/07/projection-mercator/)
3. [Mercator game](https://gmaps-samples.googlecode.com/svn/trunk/poly/puzzledrag.html)
4. [Basic GIS data types](https://en.wikipedia.org/wiki/Well-known_text#Geometric_objects)
5. [Drawing maps with Mapbox Studio Classic](https://www.mapbox.com/guides/getting-started-studio/)
6. [Styling maps with CartoCSS in Mapbox Studio Classic](https://github.com/mapbox/osm-bright)
7. [Overview of some basic GIS functions](http://postgis.net/docs/manual-2.2/using_postgis_dbmanagement.html#qa_total_length_roads):
  - [st_touches](http://postgis.net/docs/ST_Touches.html)
  - [st_intersects](http://postgis.org/docs/ST_Intersects.html)
  - [st_distance](http://www.postgis.org/docs/ST_Distance.html)
  - [st_dwithin](http://postgis.net/docs/ST_DWithin.html)
  - [st_contains](http://postgis.net/docs/manual-1.4/ST_Contains.html)
  - [st_area](http://postgis.org/docs/ST_Area.html)
8. [Spatial indices](http://revenant.ca/www/postgis/workshop/indexing.html)

## SQL tricks you might find useful

### Cross joins

You'll be using cross joins (cartesian joins) a lot, because often, there is
no column to join on. The regular join syntax requires an `ON` clausule, so
something like the following is a syntax error:
````
SELECT * FROM planet_osm_lines l
  JOIN planet_osm_polygons p 
 WHERE p.name = 'Karlova Ves'
````
Instead, you need to do
````
SELECT * FROM planet_osm_lines l 
 CROSS JOIN planet_osm_polygons p
 WHERE p.name = 'Karlova Ves'
````

### `WITH` clausule

When you need to use a subselect, the query can often get very hairy and
unreadable. Alternatively, you can first set up all subqueries and then just
reference them, e.g.:

````
WITH leisure AS (
  SELECT * FROM planet_osm_polygon p
  WHERE leisure IS NOT NULL
)
SELECT SUM(st_area(way)) FROM leisure
````

*TODO: better example*

## Homework

1. How far (air distance) is FIIT STU from the Bratislava main train station?
   The query should output the distance in meters without any further
   modification.

   *Hint: notice the difference between geometry and geography types in this
   case.*

2. Which areas (districts, cities, mountains) are direct neighbours with
   'Karlova Ves'?

3. Which streets connect with 'Molecova' street?

4. Find names of all streets in 'Dlhé diely' district.

5. What percentage of area of 'Dlhé diely' is available for leisure? (such as
   parks, tennis courts, etc.)

6. In which restaurants can you enjoy a view of the Danube river? Let's say
   that the air distance must be less than 300 meters.

  *Hint: The Danube river is composed of multiple lines and polygons*

## Recommended reading

- [PostGIS in Action](https://www.manning.com/books/postgis-in-action-second-edition)
- [List of OSM tags](http://wiki.openstreetmap.org/wiki/Category:En_tag_descriptions)
