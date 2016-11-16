# Session 6 - Fulltext

## Setup

```
docker run -p 5432:5432 fiitpdt/postgres-fulltext
docker run -p 9200:9200 elasticsearch:5.0.1
docker pull fiitpdt/elastic-import
```

## Excercises

1. **[use pen&paper]** Let A and B be two documents and the underlined words their tokens
  ```
  A: _Nine_ _little_ _friends_ are _lying_ in the _bed_
  B: The _little_ one _said_: "_Roll_ _over_"!
  ```
   and a query
  ```
  Q: little friends
  ```
   - construct a boolean model
   - rank Q by a vector similarity metric
   - rank Q using TF.IDF
   
2. **[use fiitpdt/postgres-fulltext]** Implement fulltext search in contracts (case insensitive, diacritic insensitive). Prefer matches in contract name.

3. **[use elasticsearch]** Implement fulltext search in contracts using elasticsearch (case insensitive, diacritic insensitive). It should support searching by contract name, department, customer, supplier, by supplier ICO, by contract code and by contract code prefixes (such as `168/OIaMIS`). Show a breakdown by departments and by price range.

  You will need to define a mapping first. You can run `docker run -it --net=host fiitpdt/elastic-import` to import the data from postgresql to elasticsearch. It operates on a few assumputions:
  
  - postgresql is listening on localhost:5432
  - elasticsearch is listening on localhost:9200
  - index name is `contracts`, type name is `contract`
  
  If you use chrome, I recommend using [Sense](https://chrome.google.com/webstore/detail/sense-beta/lhjgkmllcaadmopgmanpapmpjgmfcfig) to interact with Elasticsearch.

## Recommended reading
- http://www.postgresql.org/docs/9.4/static/textsearch.html
- http://www.postgresql.org/docs/9.4/static/unaccent.html
- https://www.elastic.co/guide/en/elasticsearch/guide/current/_creating_an_index.html
- https://www.elastic.co/guide/en/elasticsearch/guide/current/search-in-depth.html
- https://www.elastic.co/guide/en/elasticsearch/guide/current/aggregations.html

