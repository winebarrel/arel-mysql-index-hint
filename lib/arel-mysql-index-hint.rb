require "active_support"

ActiveSupport.on_load :active_record do
  require "arel-mysql-index-hint/active_record-hint_methods"
  require "arel-mysql-index-hint/active_record-querying"
  require "arel-mysql-index-hint/arel-visitors-mysql"
end
