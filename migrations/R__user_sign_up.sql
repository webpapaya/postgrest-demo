create or replace function
user_sign_up(email text, pass text) returns VOID as $$
declare
  user_id numeric;
  role_id text;
begin
  INSERT INTO basic_auth.users (email, pass, role)
  VALUES (email, pass, 'member')
  returning id
  into user_id;

  select concat('user', cast(user_id as text)) into role_id;

  EXECUTE 'CREATE role ' || role_id;
  EXECUTE 'GRANT member TO ' || role_id;

  update basic_auth.users 
  set role = role_id 
  where id = user_id;
end;
$$ language plpgsql SECURITY DEFINER;