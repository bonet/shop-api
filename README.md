# Shop API

This Rails project is using Rails 5.1.4, Ruby version 2.4.1, and PostgreSQL database

This is a Shop API that are listing the following in JSON format:
- List of products (/products)
- Product info (/products/:id)

To install dependencies, run `$ bundle`

Then, when we need to migrate the database: 
1. Make sure that PostgreSQl database is installed and running on your machine
2. Copy `config/database.yml.sample` to `config/database.yml` and update the content with your database credentials
3. Run `$ rake db:migrate`

To populate test data, run `$ rake db:seed` after the database is migrated

To run the server at localhost port 3000, run `$ rails s`
