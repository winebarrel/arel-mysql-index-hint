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
Article.hint(idx_article: :force)
# => "SELECT `articles`.* FROM `articles` FORCE INDEX (`idx_article`)"

Article.joins(:comments).hint(articles: {idx_article: :use})
# => "SELECT `articles`.* FROM `articles` USE INDEX (`idx_article`) INNER JOIN `comments` ON `comments`

Article.joins(:comments).hint(comments: {idx_comment: :force})
# => "SELECT `articles`.* FROM `articles` INNER JOIN `comments` FORCE INDEX (`idx_comment`) ON `comments"
```

## Related Links

* [MySQL::MySQL 5.6 Reference Manual::13.2.9.3 Index Hint Syntax](https://dev.mysql.com/doc/refman/5.6/en/index-hints.html)
