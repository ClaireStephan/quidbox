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

* How to run the test suite
> rails db:migrate RAILS_ENV=test

> bundle exec rake

* Swagger documentation

generate json files
> rake swagger:docs

access it (with rail server up)
> http://localhost:3000/apidocs/index.html

