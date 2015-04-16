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
Article.joins(:comments).hint(articles: {idx_article: :use})
# => "SELECT `articles`.* FROM `articles` use INDEX (idx_article) INNER JOIN `comments` ON `comments`

Article.joins(:comments).hint(comments: {idx_comment: :force})
# => "SELECT `articles`.* FROM `articles` INNER JOIN `comments` force INDEX (idx_comment) ON `comments"
```
