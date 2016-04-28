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

TEST_MYSQL_HOST = '127.0.0.1'
TEST_MYSQL_PORT = 3306
TEST_MYSQL_USER = 'root'
TEST_MYSQL_PASS = 'password'
MYSQL_CLI = "MYSQL_PWD=#{TEST_MYSQL_PASS} mysql -h #{TEST_MYSQL_HOST} -P #{TEST_MYSQL_PORT} -u #{TEST_MYSQL_USER}"

ActiveSupport::Notifications.subscribe('sql.active_record') do |name, start, finish, id, payload|
  sql = payload[:sql]
  $__arel_mysql_index_hint_sql_log__ << sql.gsub(/\s+/, " ") if sql
end

RSpec.configure do |config|
  config.before(:all) do
    init_database

    ActiveRecord::Base.establish_connection(
      adapter: 'mysql2',
      database: 'arel_mysql_index_hint_test',
      host: TEST_MYSQL_HOST,
      port: TEST_MYSQL_PORT,
      username: TEST_MYSQL_USER,
      password: TEST_MYSQL_PASS,
    )
  end

  config.before(:each) do
    $__arel_mysql_index_hint_sql_log__.clear
  end
end

def init_database
  sql_file = File.expand_path('../init.sql', __FILE__)
  system("#{MYSQL_CLI} < #{sql_file}")
end

def sql_log
  $__arel_mysql_index_hint_sql_log__.dup
end
