-- db: oz

-- ====== Query Plan Basics =======

-- 1. ako vyzera query plan?

select * from documents;
select * from documents where supplier = 'SPP';
select * from documents where supplier = 'SPP' order by created_at desc;
select * from documents where supplier = 'SPP' order by created_at desc limit 10;

-- na disku:
--bloky

SELECT relname, pg_size_pretty(pg_relation_size(oid)) AS "size" FROM pg_class where relname = 'documents';
SELECT relname,round(reltuples / relpages) AS rows_per_page FROM pg_class WHERE relname='documents';


select pg_stat_reset();
select * from table_stats;

-- startup cost, node cost

select * from documents where supplier = 'SPP' order by created_at desc limit 10;

-- hladanie optimalneho query planu

show seq_page_cost;
show random_page_cost;
show cpu_index_tuple_cost;

-- statistiky

select
tablename,attname,null_frac,avg_width,n_distinct,correlation,
most_common_vals,most_common_freqs,histogram_bounds
from pg_stats
where tablename='documents';

-- db: oz

-- ====== Indexing Basics =======

-- co je to index

http://www.google.sk/imgres?client=ubuntu-browser&sa=X&biw=1541&bih=777&tbm=isch&tbnid=ZPbvsH3LVHij9M%3A&imgrefurl=http%3A%2F%2Fdocs.oracle.com%2Fcd%2FB19306_01%2Fserver.102%2Fb14220%2Fschema.htm&docid=0dqo2LXWpMJpFM&imgurl=http%3A%2F%2Fdocs.oracle.com%2Fcd%2FB19306_01%2Fserver.102%2Fb14220%2Fimg%2Fcncpt169.gif&w=624&h=355&ei=u4YnU_26DsKDtAbl14EQ&zoom=1&ved=0CHAQhBwwCQ&iact=rc&dur=3264&page=1&start=0&ndsp=21

-- cena indexu/nevyhody?

SELECT relname, pg_size_pretty(pg_relation_size(oid)) AS "size" FROM pg_class where relname = 'index_documents_on_type';


-- 4 dopyty

create index index_documents_on_type on documents(type);
select * from documents where type = 'Egovsk::Appendix'; --index scan
select * from documents where type = 'Crz::Appendix'; -- bitmap idx scan & bitmap heap scan
select * from documents where type = 'Crz::Contract'; -- seq scan

select type, count(*)
from documents
group by type;


select id, type from documents where type = 'Egovsk::Appendix'; -- index only scan

select pg_stat_reset();
select * from table_stats;

--statistiky

select
tablename,attname,null_frac,avg_width,n_distinct,correlation,
most_common_vals,most_common_freqs,histogram_bounds
from pg_stats
where tablename='documents';

"{Crz::Contract,Crz::Appendix,Egovsk::Contract,Egovsk::Appendix}"
"{0.919333,0.0477333,0.0306,0.00233333}"

-- order by

select * from documents order by published_on desc;

create index index_documents_on_published_on on documents(published_on);

-- pipelined ordered by

drop index index_documents_on_published_on;

select * from documents order by published_on limit 10;

create index index_documents_on_published_on on documents(published_on);

select * from documents order by published_on limit 10;

-- modifikacie?

create index index_documents_on_supplier on documents(supplier);

select * from documents where supplier = 'SPP';
select * from documents where lower(supplier) = lower('SPP');

create index index_documents_on_lower_supplier on documents(lower(supplier));

create index idx2 on projects(reverse(project_code))

