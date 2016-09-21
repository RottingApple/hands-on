explain select * from documents;

-- explain ommited from now on

select * from documents where supplier = 'SPP';
select * from documents where supplier = 'SPP' order by created_at desc;
select * from documents where supplier = 'SPP' order by created_at desc limit 10;

-- on disk

SELECT relname, pg_size_pretty(pg_relation_size(oid)) AS "size" FROM pg_class where relname = 'documents';
SELECT relname,round(reltuples / relpages) AS rows_per_page FROM pg_class WHERE relname='documents';

select pg_stat_reset();
select * from table_stats;

-- startup cost, node cost

select * from documents where supplier = 'SPP' order by created_at desc limit 10;

-- cost based optimizer

show seq_page_cost;
show random_page_cost;
show cpu_index_tuple_cost;

-- statistics

select
tablename,attname,null_frac,avg_width,n_distinct,correlation,
most_common_vals,most_common_freqs,histogram_bounds
from pg_stats
where tablename='documents';

