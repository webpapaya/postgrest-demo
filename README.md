# Run locally
docker-compose up

# Run db migrations
docker-compose run flyway -url=jdbc:postgresql://db:5432/compup -user=dbuser -password=password migrate
docker-compose restart server

# What is PostgREST

PostgREST is a standalone web server that turns your PostgreSQL database directly into a RESTful API. The structural constraints and permissions in the database determine the API endpoints and operations.

- Simple CRUD operations for your postgres database
    - Pretty expressive query interface
    - Resource embedding is supported
    - Pagination Support
    - Authorisation via Postgres Roles and Row Level Security
    - Support for views (when you need derived data)

- Interprocess communication with pg_notify (eg. websockets/server sent events are possible)
    - https://medium.com/@simon.white/postgres-publish-subscribe-with-nodejs-996a7e45f88

# When I think you could use it?
- For prototyping
    - When building something new you need a database anyways
    - If idea is validated you could replace postgrest by something else
- Small projects where you're the only API user

# Problems I encountered so far/uncertainties
- Testing?
    - How to reset to an initial state?
- Where to put business logic? (stored procedures/...)
- Validations? (postgres only returns the first validation error)
- Scaling? (people said they could handle up to 3000 req/sec on a heroku small dyno)
    - Highly depends on the size of the database


