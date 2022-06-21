# README

This is my app, to show off my skills in Ruby on Rails
To get it up and running, please follow the steps below:

Switch to Ruby 3.0.3

If you don't have PostgreSQL installed, I recommend you do it before following next steps.

Next use the commands below:

rails bundle install

rails db:create

rails db:migrate

rails db:seed

rails s

If you want to run a test suite, use:

bundle exec rspec