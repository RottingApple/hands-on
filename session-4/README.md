# Session 4 - OO SQL

## Setup

````
sudo docker run -p 5432:5432 fiitpdt/postgres
````

## Excercises

1. **[use fiitpdt/postgres for this excercise]** Suppose the following relational schema exists, where there are travel agents selling flights to some destination. A flight can have multiple services from the set `{business class, lunch, drinks, priority boarding, online check-in}`.

  ````
  AGENT (**a_id**, name)
  FLIGHT (**destination**, pilot_name, a_id)
  SERVICE (**flight**, **service**)
  ````

  - Transform this schema to an object version using *2* data types 
  - Insert some test data
  - Write query which returns services provided on a flight to London. Results should be in 1st normal form

2. **[use fiitpdt/postgres for this excercise]** You need to keep records of your racing cars (each car has a make, model, engine performance) and your drivers and mechanics (you need to keep records of their name, address and a skill set (unbounded)). Each car has a single responsible mechanic and a single driver.

  Create a schema with custom types, insert some test data and write queries to:
  
  - find a mechanic who can also drive (assuming that 'driving' is a skill)
  - find cars which has both the mechanic and the driver living at the same address
  - find the top skill of each driver (assuming that skills are ordered, starting with the most relevant)

## Recommended reading

- http://www.postgresql.org/docs/9.2/static/rowtypes.html
- http://www.postgresql.org/docs/9.4/static/arrays.html
- http://waelchatila.com/2005/05/18/1116485743467.html
