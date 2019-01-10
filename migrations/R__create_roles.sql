create schema if not exists setup;

create or replace function
setup.create_role(role text, options text) returns VOID as $$
begin
  IF NOT EXISTS (
    SELECT             -- SELECT list can stay empty for this
    FROM   pg_catalog.pg_roles
    WHERE  rolname = role) THEN

  EXECUTE 'CREATE role ' || role;
   END IF;
end;
$$ language plpgsql SECURITY DEFINER;

create or replace function
setup.grant_privilege(privileges text, on_whom text) returns VOID as $$
begin
  EXECUTE 'ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ' || privileges || ' ON ' || on_whom || ' to anon';
  EXECUTE 'GRANT ' || privileges || ' ON ALL ' || on_whom || ' IN SCHEMA public to anon'; 
end;
$$ language plpgsql SECURITY DEFINER;

-- CREATE ROLES

select setup.create_role('authenticator', 'noinherit');
select setup.create_role('anon', '');
select setup.create_role('member', '');

grant anon to authenticator;
grant anon to member;

select setup.grant_privilege('select, insert, update, delete', 'TABLES');
select setup.grant_privilege('usage', 'SEQUENCES');
select setup.grant_privilege('execute', 'FUNCTIONS');

drop schema setup cascade;