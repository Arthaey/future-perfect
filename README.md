# Future Perfect

[![Build Status](https://travis-ci.org/Arthaey/future-perfect.svg?branch=master)](https://travis-ci.org/Arthaey/future-perfect)


# Setup

1. copy `.env.sample` to `.env.development`, `.env.test`, and `.env.production`.
   Set the variables in those files as desired.

## Database

1. start Postgres
1. `createuser -s future-perfect`
1. `psql`
      - `\password future-perfect`
      - '\q'
1. `rake db:create`
1. `rake db:migrate`
1. `RAILS_ENV=test rake db:create`
1. `RAILS_ENV=test rake db:migrate`

# Tests

`rake spec` (or `rspec`)
