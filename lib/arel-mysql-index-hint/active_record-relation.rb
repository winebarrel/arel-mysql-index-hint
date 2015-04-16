class ActiveRecord::Relation
  def with_index_hint(index_hint_by_table)
    self.visitor.index_hint_by_table = index_hint_by_table.with_indifferent_access
    self
  end
end
