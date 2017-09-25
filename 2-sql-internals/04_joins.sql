select count(*) from character;
select count(*) from paragraph;
select count(*) from work;
select count(*) from chapter;

-- hash join:
select * from paragraph p
   join character c on p.charid = c.charid

-- nested loop:
set enable_hashjoin=off 
set enable_mergejoin=off

select * from character c
   join paragraph p on p.charid = c.charid

create index idx_paragraph_on_charid on paragraph(charid);

select * from character c
   join paragraph p on p.charid = c.charid

set enable_hashjoin=on 
set enable_mergejoin=on

-- reversed! card(c) < card(d)

-- merge join
select * from paragraph a
   join wordform b on a.paragraphid = b.wordformid

-- join makes no sense, just to showcase a merge join

-- multi join
select *
   from character c
   join character_work cw on c.charid = cw.charid
   join work w on w.workid = cw.workid

-- genetic query optimizer
-- 1-2-3-4-5


-- left/right join

select * from paragraph p
   left join character c on p.charid = c.charid


