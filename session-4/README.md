# Session 4 - OO SQL

## Setup

````
sudo docker run -i -t --privileged=true --name="db2inst1" -p 50000:50000 angoca/db2-instance
./createInstance
db2

> create database pdt using codeset UTF-8 territory en
> connect to pdt

````

## Excercises

1. Suppose the following relational schema exists, where there are travel agents selling flights to some destination. A flight can have multiple services from the set `{business class, lunch, drinks, priority boarding, online check-in}`.

````
AGENT (**a_id**, name)
FLIGHT (**destination**, pilot_name, a_id)
SERVICE (**flight**, **service**)
````

- Transform this schema to an object version using *2* data types 
- Insert some test data
- Write query which returns services provided on a flight to London. Results should be in 1st normal form.
