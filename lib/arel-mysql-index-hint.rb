require "active_support"

ActiveSupport.on_load :active_record do
  require "arel-mysql-index-hint/active_record-hint_methods"
  require "arel-mysql-index-hint/arel-visitors-mysql"

  ActiveRecord::Relation.class_eval do
    include ArelMysqlIndexHint::ActiveRecordHintMethods
  end

  ActiveRecord::Querying.class_eval do
    delegate :hint, :to => :all
  end

  Arel::Visitors::MySQL.class_eval do
    include ArelMysqlIndexHint::ArelVisitorsMySQL
  end
end
