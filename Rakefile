#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Tune::Application.load_tasks

task :deploy do
  `bundle exec rake assets:precompile RAILS_ENV=development`
  #`heroku mongo:sync`
  `git add . ; git commit -a -m 'deploy'`
  `git push heroku master`
end
