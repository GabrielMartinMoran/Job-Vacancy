Job Vacancy Application
=======================

[![build status](https://gitlab.com/untref-ingsoft/tps/king/badges/master/build.svg)](https://gitlab.com/untref-ingsoft/tps/king/commits/master)

## Miembros del equipo

* Germán Ariel Torós
* Gabriel Martín Moran

## URL de la aplicación

* **Staging:** http://kingjobvacancystaging.herokuapp.com/
* **Production:** http://kingjobvacancy.herokuapp.com/

## PostgreSQL setup

Follow these steps to initialize the PostgreSQL databases:

1. Install PostgreSQL if needed. On Ubuntu you can do this by running:
`sudo apt-get install -y postgresql-9.5 postgresql-contrib postgresql-server-dev-9.5`
1. Create development and test databases by running:
`sudo -u postgres psql --dbname=postgres -f ./create_dev_and_test_dbs.sql`

## Padrino application setup

1. Run **_bundle install --without staging production_**, to install all application dependencies
1. Run **_bundle exec rake_**, to run all tests and ensure everything is properly setup
1. Run **_RACK_ENV=development bundle exec rake db:migrate db:seed_**, to setup the development database
1. Run **_bundle exec padrino start -h 0.0.0.0_**, to start the application

For authenticating as an offerer you can use the credentials offerer@test.com / Passw0rd!

## Some conventions to work on it:

* Follow existing coding conventions
* Use feature branch
* Add descriptive commits messages in English to every commit
* Write code and comments in English
* Use REST routes
