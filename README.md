# cat-a-log API

### API used by https://github.com/budiharta21/cat-a-log

## Instalation Step
1. Clone this repository
2. Run `bundle install`
3. Setup your `database.yml`, you can use `database.yml.example`
4. Run `rails db:create` to create database on postgresql
5. Run `rails db:migrate` to migrate all table
5. Run `rails db:seed` to run all data seed

## Running with Docker and Docker Compose
1. Clone this repository
2. Run `docker-compose up`
3. Configure your database by copying `config/database.yml.example` into `config/database.yml`. Make sure postgresql running on port 5432 with username `postgres` and password `secret`
4. Run `docker-compose exec web rails db:migrate` to migrate the database
5. Run `docker-compose exec web rails db:seed` to run database seeds
