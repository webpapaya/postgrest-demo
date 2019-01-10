create table if not exists
public.users (
  id     SERIAL PRIMARY KEY,
  name   text NOT NULL,
  role   name DEFAULT current_role UNIQUE
);