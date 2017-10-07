# Future Perfect

[![Bugs](https://img.shields.io/github/issues/Arthaey/future-perfect/bug.svg)](https://github.com/Arthaey/future-perfect/issues?q=is:open+is:issue+label:bug)
[![Build Status](https://travis-ci.org/Arthaey/future-perfect.svg?branch=master)](https://travis-ci.org/Arthaey/future-perfect)
[![Coverage Status](https://coveralls.io/repos/github/Arthaey/future-perfect/badge.svg)](https://coveralls.io/github/Arthaey/future-perfect)
[![Code Climate](https://codeclimate.com/github/Arthaey/future-perfect.png)](https://codeclimate.com/github/Arthaey/future-perfect)


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
1. `rake db:create RAILS_ENV=test`
1. `rake db:migrate RAILS_ENV=test`

# Tests

`rake spec` (or `rspec`)
