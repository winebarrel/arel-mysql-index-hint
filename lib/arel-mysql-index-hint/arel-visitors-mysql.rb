module ArelMysqlIndexHint
  module ArelVisitorsMySQL
    def visit_Arel_Table(o, a)
      sql = super

      if o.index_hint
        append_index_hint(sql, o.index_hint)
      else
        sql
      end
    end

    private

    def append_index_hint(sql, index_hint)
      index_hint_sql = index_hint.map {|hint_type, index|
        index = Array(index).map {|i| quote_table_name(i) }
        hint_type = hint_type.to_s.upcase
        "#{hint_type} INDEX (#{index.join(', ')})"
      }.join(" ")

      if sql.is_a?(String)
        sql + " " + index_hint_sql
      else
        sql << " " + index_hint_sql
        sql
      end
    end
  end
end
