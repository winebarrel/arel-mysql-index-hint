class ActiveRecord::Base
  def self.with_index_hint(index_hint_by_table)
    relation = yield
    relation.visitor.index_hint_by_table = index_hint_by_table.with_indifferent_access
    relation
  end

  def with_index_hint(index_hint_by_table, &block)
    self.class.with_index_hint(index_hint_by_table, &block)
  end
end
