-- hashaggregate
select status
   from crz_document_details d
   group by status

-- sort + groupaggregate
select supplier
   from crz_document_details d
   group by supplier

-- groupaggregate
create index index_supplier_on_cdd on crz_document_details(supplier)

select supplier
   from crz_document_details d
   group by supplier
   limit 100;

create index index_cds_on_department_supplier on crz_document_details(department, supplier)

select supplier
   from crz_document_details d
   where department = 'Ministerstvo kultúry SR'
   group by supplier
   limit 10;
