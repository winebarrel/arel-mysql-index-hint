class ActiveRecord::Relation
  def hint(index_hint_by_table)
    self.visitor.index_hint_by_table = {}.with_indifferent_access
    self.visitor.index_hint_by_table.update(index_hint_by_table)
    self
  end
end
