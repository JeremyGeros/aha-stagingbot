# aha-stagingbot

aha-stagingbot is a Slack bot to track staging environments

## Development

### Prerequisites

* git
* ruby 2.3.0 ([rvm](https://rvm.io/) recommended)
* [postgres](http://www.postgresql.org/) (`brew install postgres` on OSX)

### Setup

* Clone the repository (`git clone git@github.com:Bernie-2016/text-for-bernie-api.git`)
* Install gem dependencies: `bundle install`
* `psql -h localhost`; inside pg, run `create database aha_stagingbot`, `\c aha_stagingbot`, and 
```
CREATE TABLE servers (
  id serial PRIMARY KEY,
  name varchar (50) NOT NULL,
  claimed boolean,
  claimed_by varchar (50),
  claimed_at timestamp without time zone,
  claimed_for varchar(250)
);
```
* Create `.env` with SLACK_API_TOKEN and DATABASE_URL
* Run `foreman start` and start interacting with your Slackbot!

## Contributing

1. Fork it ( https://github.com/aha-app/aha-stagingbot/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request
