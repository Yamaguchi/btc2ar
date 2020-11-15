# btc2ar

Tool for importing Bitcoin Blockchain data into Relational database (using ActiveRecord)

## Install

git clone https://github.com/Yamaguchi/btc2ar
cd btc2ar
bundle install

## Setup

bin/rails db:create db:migrate db:seed
bin/rails s

## Start Service

### On Development 
bin/rails jobs:work
bin/rails blockchain:start

### On Production
bin/delayed_job start
RAILS_ENV=production bin/rails blockchain:start

## Note

- To configure the connection for bitcoin core, edit config/bitcoin.yml
