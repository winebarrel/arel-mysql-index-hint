class Arel::Visitors::MySQL
  attr_writer :index_hint_by_table

  def visit_Arel_Table_with_index_hint(o, a)
    sql = if o.table_alias
            "#{quote_table_name o.name} #{quote_table_name o.table_alias}"
          else
            quote_table_name o.name
          end

    index_hint = @index_hint_by_table.try(:[], o.name)

    if index_hint
      appent_index_hint(sql, index_hint)
    else
      sql
    end
  end

  alias_method_chain :visit_Arel_Table, :index_hint

  private

  def with_index_hint(o)
    if o.is_a?(Arel::Table)
      begin
        o.index_hint = @index_hint_by_table.try(:[], o.name)
        yield(o)
      ensure
        o.index_hint = nil
      end
    else
      yield(o)
    end
  end

  def appent_index_hint(sql, index_hint)
    sql + " " + index_hint.map {|index, hint_type|
      index = Array(index)
      "#{hint_type} INDEX (#{index.join(', ')})"
    }.join(", ")
  end
end
