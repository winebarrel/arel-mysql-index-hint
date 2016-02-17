require "active_support"
require "arel-mysql-index-hint/version"

ActiveSupport.on_load :active_record do
  require "arel-mysql-index-hint/active_record-hint_methods"
  require "arel-mysql-index-hint/arel-table"
  require "arel-mysql-index-hint/arel-visitors-mysql"

  ActiveRecord::Relation.class_eval do
    prepend ArelMysqlIndexHint::ActiveRecordHintMethods
  end

  ActiveRecord::Querying.class_eval do
    delegate :hint, :to => :all
  end

  Arel::Table.class_eval do
    prepend ArelMysqlIndexHint::ArelTable
  end

  Arel::Visitors::MySQL.class_eval do
    prepend ArelMysqlIndexHint::ArelVisitorsMySQL
  end
end
