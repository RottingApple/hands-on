-- What is index:
-- http://docs.oracle.com/cd/B19306_01/server.102/b14220/img/cncpt169.gif

-- index price/disadvantages

SELECT relname, pg_size_pretty(pg_relation_size(oid)) AS "size" FROM pg_class where relname = 'index_documents_on_type';


-- 4 queries, 4 query plans

create index index_documents_on_type on documents(type);
select * from documents where type = 'Egovsk::Appendix'; --index scan
select * from documents where type = 'Crz::Appendix'; -- bitmap idx scan & bitmap heap scan
select * from documents where type = 'Crz::Contract'; -- seq scan

select type, count(*)
from documents
group by type;

select type from documents where type = 'Egovsk::Appendix'; -- index only scan

select pg_stat_reset();
select * from table_stats;

--statisttics

select
tablename,attname,null_frac,avg_width,n_distinct,correlation,
most_common_vals,most_common_freqs,histogram_bounds
from pg_stats
where tablename='documents';

"{Crz::Contract,Crz::Appendix,Egovsk::Contract,Egovsk::Appendix}"
"{0.919333,0.0477333,0.0306,0.00233333}"

-- order by

select * from documents order by published_on asc;
select * from documents order by published_on desc;

create index index_documents_on_published_on on documents(published_on);

-- pipelined ordered by

drop index index_documents_on_published_on;

select * from documents order by published_on limit 10;

create index index_documents_on_published_on on documents(published_on);

select * from documents order by published_on limit 10;

-- modifications?

create index index_documents_on_supplier on documents(supplier);

select * from documents where supplier = 'SPP';
select * from documents where lower(supplier) = lower('SPP');

create index index_documents_on_lower_supplier on documents(lower(supplier));
