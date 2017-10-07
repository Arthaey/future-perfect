# Future Perfect

[![Build Status](https://travis-ci.org/Arthaey/future-perfect.svg?branch=master)](https://travis-ci.org/Arthaey/future-perfect)


# Setup

## Database

1. start Postgres
1. `createuser -s future-perfect`
1. `psql`
      - `\password future-perfect` with "future-perfect" password
        (dev &amp; test, _not prod!_)
      - '\q'
1. `rake db:create`
1. `rake db:migrate`
1. `RAILS_ENV=test rake db:create`
1. `RAILS_ENV=test rake db:migrate`

# Tests

`rake spec` (or `rspec`)
