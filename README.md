# README

This app is to show my skills in Ruby on Rails.

It allows users to create an account, so they can write articles or comments and follow other accounts. Follow feature enables users to view articles made by followed users on their feed page. There is admin role which allows admin users to view users index page and delete specific users, articles or comments.

To get it up and running, please follow the steps below.

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

(all seeded users have password "password")
