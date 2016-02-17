# arel-mysql-index-hint

Add index hint to MySQL query in Arel.

[![Gem Version](https://badge.fury.io/rb/arel-mysql-index-hint.svg)](http://badge.fury.io/rb/arel-mysql-index-hint)
[![Build Status](https://travis-ci.org/winebarrel/arel-mysql-index-hint.svg?branch=master)](https://travis-ci.org/winebarrel/arel-mysql-index-hint)
[![Coverage Status](https://img.shields.io/coveralls/winebarrel/arel-mysql-index-hint.svg)](https://coveralls.io/r/winebarrel/arel-mysql-index-hint?branch=master)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'arel-mysql-index-hint'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install arel-mysql-index-hint

## Usage

```ruby
Article.hint(force: :idx_article)
#=> "SELECT `articles`.* FROM `articles` FORCE INDEX (`idx_article`)"

Article.hint(force: [:idx_article, :idx_article2])
#=> "SELECT `articles`.* FROM `articles` FORCE INDEX (`idx_article`, `idx_article`)"

Article.hint(use: :idx_article, ignore: :idx_article2)
#=> "SELECT `articles`.* FROM `articles` USE INDEX (`idx_article`) IGNORE INDEX (`idx_article`)"

Article.joins(:comments).hint(articles: {use: :idx_article})
#=> "SELECT `articles`.* FROM `articles` USE INDEX (`idx_article`) INNER JOIN `comments` ON `comments`

Article.joins(:comments).hint(comments: {force: :idx_comment})
#=> "SELECT `articles`.* FROM `articles` INNER JOIN `comments` FORCE INDEX (`idx_comment`) ON `comments"
```

## Running tests

```sh
docker-compose up -d
bundle install
bundle exec appraisal install
bundle exec appraisal activerecord-4.0 rake
bundle exec appraisal activerecord-4.1 rake
bundle exec appraisal activerecord-4.2 rake
```

**Notice:** mysql-client is required.

### on OS X (docker-machine & VirtualBox)

Port forwarding is required.

```sh
VBoxManage controlvm default natpf1 "mysql,tcp,127.0.0.1,3306,,3306"
```

## Related Links

* [MySQL::MySQL 5.6 Reference Manual::13.2.9.3 Index Hint Syntax](https://dev.mysql.com/doc/refman/5.6/en/index-hints.html)
