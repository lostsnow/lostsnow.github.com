Ruby Installation
=================

curl CA
-------

./mk-ca-bundle.pl
curl-config --ca

ruby source
-----------

    gem sources --remove http://rubygems.org/
    gem sources -a http://ruby.taobao.org/
    gem sources -l

ruby with rvm
-------------

    rvm install ruby-1.8.7-p357
    rvm ruby-1.8.7-p357
    rvm gemset create redmine1.3
    rvm ruby-1.8.7-p357@redmine1.3

    gem install bundler

    gem install passenger
    gem install bluefeather

redmine
-------

./Gemfile

    source "http://ruby.taobao.org/"
    gem "rails", "2.3.14"
    gem "rake", "0.8.3"
    gem "rack", "1.1.0"
    gem "i18n", "0.4.2"
    gem "rubytree", "0.5.2", :require => "tree"
    gem "RedCloth", "~>4.2.3", :require => "redcloth" # for CodeRay
    gem "mysql"
    gem "coderay", "~>0.9.7"
    gem "shoulda", "~>2.10.3"
    gem "edavis10-object_daddy", ">=0"
    gem "mocha", ">=0"

    bundle install

### config ###

./config/environment.rb

    ENV['RAILS_ENV'] ||= 'production'

    config.active_record.table_name_prefix = "redmine_"

./config/database.yml

### init ###

RAILS_ENV=production bundle exec rake generate_session_store
RAILS_ENV=production bundle exec rake db:migrate
RAILS_ENV=production bundle exec rake redmine:load_default_data

### deploy ###

    #mv dispatch.cgi.example dispatch.cgi
    #mv dispatch.fcgi.example dispatch.fcgi
    #mv dispatch.rb.example dispatch.rb

    ruby /path/to/redmine/script/server webrick -e production -b 127.0.0.1 -d

