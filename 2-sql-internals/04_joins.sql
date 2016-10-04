select count(*) from documents;
select count(*) from comments;

-- hash join:
select * from attachments a
   join pages p on p.attachment_id = a.id

-- nested loop:
select * from documents d
   join comments c on d.id = c.document_id

-- reversed! card(c) < card(d)

-- merge join
select * from (select * from documents order by id) d
   join comments c on d.id = c.document_id


-- materialize -> what if driving table has duplicates?


-- multi join
select *
   from documents d
   join attachments a on a.document_id = d.id
   join pages p on p.attachment_id = a.id

-- genetic query optimizer
-- 1-2-3-4-5


-- left/right join

select * from documents d
   left join comments c on d.id = c.document_id

