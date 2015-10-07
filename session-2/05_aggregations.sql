-- dump: http://otvorenezmluvy.sk/data/
﻿-- group by

-- hashaggregate
select status
   from crz_document_details d
   group by status

-- sort + groupaggregate
select supplier
   from crz_document_details d
   group by supplier

-- groupaggregate
create index index_cds_on_department_supplier on crz_document_details(department, supplier)

 select supplier
   from crz_document_details d
   where department = 'Ministerstvo kultúry SR'
   group by supplier;

 select supplier
   from crz_document_details d
   where department = 'Ministerstvo kultúry SR'
   group by supplier
   limit 10;
