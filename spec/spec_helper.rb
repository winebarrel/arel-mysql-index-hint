require "arel-mysql-index-hint"

RSpec.configure do |config|
  config.before(:all) do
    init_database

    ActiveRecord::Base.establish_connection(
      adapter: 'mysql2',
      database: 'arel_mysql_index_hint_test'
    )
  end
end

def init_database
  sql_file = File.expand_path('../init.sql', __FILE__)
  system("mysql -uroot < #{sql_file}")
end

# Models
# original: https://github.com/railstutorial/sample_app_rails_4

class Micropost < ActiveRecord::Base
  belongs_to :user
end

class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
end

class User < ActiveRecord::Base
  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
end
