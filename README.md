# arel-mysql-index-hint

Add index hint to MySQL query in Arel.

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
ActiveRecord::Base.with_index_hint(comments: {any_idx_name: :force}) {
  Article.joins(:comments)
}.all

# => "SELECT `articles`.* FROM `articles` INNER JOIN `comments` force INDEX (any_idx_name) ON `comments"
```
