# How I like my Ruby on Rails apps

Ruby 3.1 with Rails 7.0 API-only app as an example of how I like my Ruby on Rails apps, which tools I like to use - and how I like to structure and write my code.

> _This README is still a draft - kind of an TODO list for myself._

## Conventions

* Ruby 3.1
* 7.0 API-only
* PostgreSQL database
* No Docker

## Customizations

* AppConf
* Authentication _(not implemented yet)_
* Authorization _(not implemented yet)_
* Current dependencies
  * Ruby
  * Rails
  * gems
  * all the others
* dry-validation
* Error middleware
  * 404 handling
* GitHub Actions CI
* HTTP Client _(not implemented yet)_
* JSON:API
  * fast JSON serialization
  * fast and predictable JSON parsing
* Logging _(not implemented yet)_
* Message Queue _(not implemented yet)_
* Modular Monotlith _(not implemented yet)_
* Hotwire _(not implemented yet)_
  * as this is an API-only app, it might not be showcased here
* PostgreSQL DB
  * enums _(not implemented yet)_
  * foreign_keys, (unique) indices not null constraints _(not implemented yet)_
  * strong_migrations _(not implemented yet)_
  * UUIDs
* Rack timeouts
* rubocop _(not implemented yet)_
* README
* RSpec
  * Unit specs
  * Request specs
  * Factories
* Service pattern for business logic _(not implemented yet)_
* Swagger / OpenAPI docs _(not implemented yet)_
* task `rake ci`
  * FactoryBot and Rubocop linting
  * Running the specs
  * Auditing the bundle

### AppConf

Explain what it does and why (benefits!).

Link to commit.

Maybe show some example code.

### dry-validation

Same as above. And repeat for all others.
