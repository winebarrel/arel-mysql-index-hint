if ENV['TRAVIS']
  require 'simplecov'
  require 'coveralls'

  SimpleCov.formatter = Coveralls::SimpleCov::Formatter

  SimpleCov.start do
    add_filter "spec/"
  end
end

require "active_record"
require "arel-mysql-index-hint"
require "models"

$__arel_mysql_index_hint_sql_log__ = []

ActiveSupport::Notifications.subscribe('sql.active_record') do |name, start, finish, id, payload|
  $__arel_mysql_index_hint_sql_log__ << payload[:sql]
end

RSpec.configure do |config|
  config.before(:all) do
    init_database

    ActiveRecord::Base.establish_connection(
      adapter: 'mysql2',
      database: 'arel_mysql_index_hint_test'
    )
  end

  config.before(:each) do
    $__arel_mysql_index_hint_sql_log__.clear
  end
end

def init_database
  sql_file = File.expand_path('../init.sql', __FILE__)
  system("mysql -uroot < #{sql_file}")
end

def sql_log
  $__arel_mysql_index_hint_sql_log__.dup
end
