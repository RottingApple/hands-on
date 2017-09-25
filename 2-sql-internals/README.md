# Session 2 - Multicolumn Indices, Joins & Aggregations

## Setup

````
docker run -p 5432:5432 fiitpdt/postgres-shakespeare
````
You can now connect to postgresql server running on localhost:5432 using your client of choice. For windows and linux we recommend [pgAdmin3](http://www.pgadmin.org/download/windows.php). Install the client on your local machine, docker is only running the server.

The database with example data is called `shakespeare`, username is `postgres`, password is blank (there is no password)

## Labs

Queries presented
- [`03_multicolumn_indices.sql`](03_multicolumn_indices.sql) (use the `fiitpdt/postgres` container)
- [`04_joins.sql`](04_joins.sql) (use the `fiitpdt/postgres-shakespeare` container)
- [`05_aggregations.sql`](05_aggregations.sql) (no container available yet)

## Homework

1. Your users need to search contracts (`crz_document_details` table) by its
   special code number (`identifier` column). They want to be able to enter an
   `identifier` suffix since that is the most meaningful part of the
   identifier, e.g. they enter `2011-KE` and find documents with identifiers:
   `272/2011-KE, 19371/2011-KE, 19381/2011-KE, ..`. The length of the suffix
   which they use will vary, so you can't rely on it.

   You first come up with a naive query which uses `LIKE` (`SELECT * FROM
   crz_document_details WHERE identifier LIKE '%2011-KE'`) but quickly find out
   that is very slow (go ahead, try it). You try to add an index but quickly
   find out that is makes no difference (go ahead, try it). Think about it. 
   Why didn't the index help? Can you make this feature fast?
   
   (Make sure you create the index for `LIKE` using `text_pattern_ops`, see http://www.postgresql.org/docs/9.4/static/indexes-opclass.html for details.)

   *Hint: function-based index*

2. Your users want to see the top 10 recent documents ordered by date of
   publication (`published_on asc`) and when there are multiple documents from the
   same day, then they want it ordered by the contracted amount
   (`total_amount desc`) from the highest price to the lowest price. Write a *fast*
   query.

3. Find out any documents (`crz_document_details` table) with any company
   (`supplier_ico`) that was dissolved on 31st January 2011
   (`regis_subjects.ico`). Make the query as fast as you can *[~12 ms on my
   machine]*. Observe how the query plan changes when you change the date. Try
   1st January 2011 for example.

4. Your users want a report of all `attachments` that have at least 100
   `pages`. Make it fast. *[~14 ms on my machine]*.

5. Followup to #4. Now that you've made the query fast, find out how much space
   does the index take. It should be rather small, since we are only storing small
   numbers, but you don't need 99% of it. Use postgresql's partial indexes
   (`CREATE INDEX index_name ON table(column(s)) WHERE cond = something`) to
   reduce its size and maintenance cost.

   *Hint: If the above makes no sense than you've got a different answer to #4
   than I have.*

## Recommended reading

- http://www.depesz.com/tag/unexplainable/
- https://momjian.us/main/writings/pgsql/optimizer.pdf
- http://blog.heapanalytics.com/speeding-up-postgresql-queries-with-partial-indexes/

If you want to understand how to properly index `LIKE '%x%'` expressions (and the trade-offs), read

- http://www.depesz.com/2011/02/19/waiting-for-9-1-faster-likeilike/
- http://www.postgresql.org/docs/9.4/static/pgtrgm.html
