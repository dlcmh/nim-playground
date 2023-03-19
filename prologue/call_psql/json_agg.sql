-- run with: psql -qAtX -d diesel_demo -v id=1 -f json_agg.sql

select json_agg(row_to_json(a)) from (select id, published from posts where id = :id) a;
