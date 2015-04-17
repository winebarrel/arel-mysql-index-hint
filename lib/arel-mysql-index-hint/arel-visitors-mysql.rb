class Arel::Visitors::MySQL
  INDEX_HINT_BY_TABLE_THREAD_KEY = "INDEX_HINT_BY_TABLE_THREAD_KEY"

  def visit_Arel_Table_with_index_hint(o, a)
    sql = visit_Arel_Table_without_index_hint(o, a)
    index_hint = get_index_hint(o.name)

    if index_hint
      append_index_hint(sql, index_hint)
    else
      sql
    end
  end

  alias_method_chain :visit_Arel_Table, :index_hint

  private

  def get_index_hint(table)
    index_hint_by_table = Thread.current[INDEX_HINT_BY_TABLE_THREAD_KEY]
    index_hint_by_table.try(:delete, table)
  end

  def append_index_hint(sql, index_hint)
    sql + " " + index_hint.map {|index, hint_type|
      index = Array(index)
      "#{hint_type} INDEX (#{index.join(', ')})"
    }.join(", ")
  end
end
