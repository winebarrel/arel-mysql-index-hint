module ArelMysqlIndexHint
  module ActiveRecordHintMethods
    def mysql_index_hint_value=(value)
      @values[:mysql_index_hint] = value
    end

    def mysql_index_hint_value
      @values[:mysql_index_hint]
    end

    def hint(index_hint_by_table)
      self.mysql_index_hint_value ||= {}.with_indifferent_access
      mysql_index_hint_value.deep_merge!(index_hint_by_table)
      self
    end

    def build_arel
      arel = super

      if mysql_index_hint_value.present?
        if mysql_index_hint_value.values.any? {|i| i.is_a?(Hash) }
          index_hint_by_table = mysql_index_hint_value
        else
          index_hint_by_table = Hash.new(mysql_index_hint_value)
        end

        arel.ast.select {|i| i.is_a?(Arel::Table) }.each do |node|
          node.index_hint = index_hint_by_table[node.name]
        end
      end

      arel
    end
  end
end
