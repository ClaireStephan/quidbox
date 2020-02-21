# README

* Ruby version

ruby 2.6.5p114

* System dependencies

postgresql 12

* DB configuration

create user quidbox with login and creation rights

* Starting the server
> rails db:create

> rails db:migrate

> rails s

* How to test

run the test suite (run by github on push)
> rails db:migrate RAILS_ENV=test

> bundle exec rake

run postman collection

> located in test/Quidbox.postman_collection.json

> {{base_url}} set by default to https://quidbox-prd.herokuapp.com
You can create environment to target http://localhost:3000 instead

* Swagger documentation

generate json files
> rake swagger:docs

access it (with rail server up)
> http://localhost:3000/apidocs/index.html

* heroku

on push it is automatically deloyed on https://quidbox-prd.herokuapp.com

