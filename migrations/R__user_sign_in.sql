CREATE TYPE public.jwt_token AS (
  token text
);

create or replace function
user_sign_in(email text, pass text) returns public.jwt_token as $$
declare
  _role name;
  result public.jwt_token;
begin
  select basic_auth.user_role(email, pass) into _role;
  if _role is null then
  raise invalid_password using message = 'invalid user or password';
  end if;

  select basic_auth.sign(
    row_to_json(r), '4e5e90c6228fd48698d074241c2ba7605'
  ) as token
  from (
    select _role as role, user_sign_in.email as email,
     extract(epoch from now())::integer + 60*60000 as exp
  ) r
  into result;
  return result;
end;
$$ language plpgsql SECURITY DEFINER;