# Session 6 - Operators CUBE, ROLLUP and XML functions

## Setup

    docker run -p 5432:5432 fiitpdt/postgres-cube

## Excercises

### Cube & Rollup

Use the lecture slides and PostgreSQL documentation

- http://www2.fiit.stuba.sk/~kuric/PDT/download/PDT06b-Data_Cube.pdf
- https://www.postgresql.org/docs/9.6/static/queries-table-expressions.html

1. Use the `GROUP BY cube()` operator to construct a hypercube of (department,
   customer, supplier) showing contract counts. Observe the output. Limit it
   to, e.g. `supplier = 'ORANGE Slovensko'` to get a sensible amount of data.

2. Do the same with `ROLLUP` operator. What's the difference?

  The output probably doesn't match your expectations of what `ROLLUP` and `CUBE` should do.
  Both `NULL` values and `ALL` aggregations show up as an empty cell in the output.
  Try adding 
  
  ````sql
  WHERE supplier IS NOT NULL
  AND department IS NOT NULL
  AND customer IS NOT NULL
  ````

### XML functions

Use the PostgreSQL documentation

- https://www.postgresql.org/docs/9.6/static/functions-xml.html

1. Write a query which will output each supplier wrappped in an XML tag. Limit
   it to 10 suppliers.
   
    ````xml
    <supplier>Mekka s.r.o. Komárno</supplier>
    <supplier>Mekka s.r.o. Komárno</supplier>
    <supplier>EUROTEXTIL-AZ, s.r.o.</supplier>
    <supplier>COOP Jednota Komárno, SD</supplier>
    <supplier>SAD Nové Zámky, a.s.</supplier>
    <supplier>SPŠS Hurbanovo</supplier>
    <supplier>SPŠS Hurbanovo</supplier>
    <supplier>SPŠS Hurbanovo</supplier>
    <supplier>RIMIX</supplier>
    <supplier>Lantastik Sk, s.r.o.</supplier>
````

2. Write a query which will output a department name, and a single xml document
   with a list of suppliers for that department.

   Hint: You might want to create an index here if it's too slow.
    ````xml
    Agrokomplex – Výstavníctvo Nitra, š.p.;"<supplier>Profi Press SK, s.r.o.</supplier><supplier>Zdeněk Makovička - Vydavateľstvo ZT</supplier><supplier>Bonsaj, s.r.o.</supplier><supplier>SLOVRESTAV, spol. s r.o.</supplier><supplier>Anton Foldoši</supplier><supplier>Ľuboš Major - LUMA</supplier><sup (...)"
    Akadémia umení v Banskej Bystrici;"<supplier>Advokátska kancelária Krnáč, s.r.o.</supplier><supplier>Gamo, a.s.</supplier><supplier>GAMO, a.s.</supplier><supplier>GAMO, a.s.</supplier><supplier>Igor Meluzin, akad.mal.</supplier><supplier>GAMO, a.s.</supplier><supplier>GAMO, a.s.</supplier>< (...)"
    Audiovizuálny fond;"<supplier>ALEF Film a media Group, s.r.o.</supplier><supplier>Asociácia slovenských filmových klubov</supplier><supplier>Občianske združenie atelier.doc</supplier><supplier>Asociácia slovenských filmových klubov</supplier><supplier>ARTILERIA, s.r.o.</suppl (...)"
    Ekonomická univerzita v Bratislave;"<supplier>Ing. Zoltán Pócs - ZOPO</supplier><supplier>DEMIFOOD spol. s r.o., Nové Mesto nad Váhom</supplier><supplier>DEMIFOOD spol. s r.o., Nové Mesto nad Váhom</supplier><supplier>MABONEX Slovakia, spol. s r.o.</supplier><supplier>MABONEX Slovakia, spol. (...)"
    Fond na podporu vzdelávania;"<supplier>Delor International, spol. s. r.o., organizačná zložka</supplier><supplier>Martin Talanda – NETSYS</supplier><supplier>AENEA Legal, s.r.o.</supplier><supplier>Slovenská sporiteľňa, a.s.</supplier><supplier>Slovenská sporiteľňa, a.s.</supplier><su (...)"
    Fond národného majetku SR;"<supplier>TWINS-SK, s.r.o.</supplier><supplier>Bučina Zvolen, a.s.</supplier><supplier>Bučina Zvolen, a.s.</supplier><supplier>Ing. Katarína Tothová</supplier><supplier>Ing. Branislav Bačík</supplier><supplier>Ing. Rudolf Šamaj</supplier><supplier>Kubus Pr (...)"
    Fond výtvarných umení;"<supplier>Fond výtvarných umení</supplier>"
    Generálna prokuratúra Slovenskej republiky ;"<supplier>PROGRES - PS, s.r.o.</supplier><supplier>Orange Slovensko, a.s.</supplier><supplier>Orange Slovensko, a.s.</supplier><supplier>Práčovňa Ivka</supplier><supplier>Generálna prokuratúra Slovenskej republiky</supplier><supplier>STORIN, spol. s r.o.</ (...)"
    Hudobný fond;"<supplier>BPS PARK, a.s.</supplier><supplier>Könemann Music Budapest, Hungary</supplier><supplier>NADÁCIA JÁNA CIKKERA</supplier><supplier>autor</supplier><supplier>Ad Una Corda, o.z.</supplier><supplier>Akadémia umení v Banskej Bystrici</supplier><supplie (...)"
    Kancelária Národnej rady Slovenskej republiky;"<supplier>Ing. Elena Závacká</supplier><supplier>Odborová organizácia pri Kancelárii Národnej rady Slovenskej republiky</supplier><supplier>PhDr. Margaréta Cehláriková</supplier><supplier>MPS, s.r.o.</supplier><supplier>JUDr. Jozef Vozár, CSc.</supplier><s (...)"
    ````

3. Do the same as above, but this time, include a root `department` element
   with attributes `name` for the department name and `count` for the supplier
   count.

   Example output of a single row:

    ````xml
    <department department="Agrokomplex &#x2013; V&#xFD;stavn&#xED;ctvo Nitra, &#x161;.p." count="1157">
       <supplier>Profi Press SK, s.r.o.</supplier>
       <supplier>Zdeněk Makovička - Vydavateľstvo ZT</supplier>
       <supplier>Bonsaj, s.r.o.</supplier>
       ...
    </department>
    ````
