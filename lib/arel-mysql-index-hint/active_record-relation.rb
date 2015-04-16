class ActiveRecord::Relation
  def index_hint(index_hint_by_table)
    self.visitor.index_hint_by_table = {}.with_indifferent_access
    self.visitor.index_hint_by_table.update(index_hint_by_table)
    self
  end

  alias hint index_hint
end
