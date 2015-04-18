ActiveRecord::Querying.class_eval do
  delegate :hint, :to => :all
end
