# MusicAPI
This is an API to manage music tracks, artists and albums

## Requires:
* Ruby version: 2.7.4
* Rails 6.1

## Quick Start
1. Configuration

 Update your environment variables to match the DB configuration, must set the following variables:
* DATABASE_USER: holding the user needed to connect to the db
* DATABASE_PASSWORD: Containing the required password for that user to login
* DATABASE_HOST: Should point to the DB server

2. Database creation
 Type `rails db:create` on the app server console where the application is installed.

* Database initialization
standard `rails db:migrate; rails db:seed` to get the initial db structure and data

