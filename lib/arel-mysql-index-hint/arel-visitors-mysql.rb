class Arel::Visitors::MySQL
  attr_accessor :index_hint_by_table

  def visit_Arel_Table_with_index_hint(o, a)
    sql = visit_Arel_Table_without_index_hint(o, a)
    index_hint = @index_hint_by_table.try(:[], o.name)

    if index_hint
      append_index_hint(sql, index_hint)
    else
      sql
    end
  end

  alias_method_chain :visit_Arel_Table, :index_hint

  private

  def append_index_hint(sql, index_hint)
    sql + " " + index_hint.map {|index, hint_type|
      index = Array(index)
      "#{hint_type} INDEX (#{index.join(', ')})"
    }.join(", ")
  end
end
