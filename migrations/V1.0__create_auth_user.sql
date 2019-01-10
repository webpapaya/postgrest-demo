create schema if not exists basic_auth;

create table if not exists
basic_auth.users (
  id     serial primary key,
  email  text check ( email ~* '^.+@.+\..+$' ) unique,
  pass   text not null check (length(pass) < 512),
  role   name not null check (length(role) < 512)
);