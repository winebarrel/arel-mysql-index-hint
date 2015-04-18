module ArelMysqlIndexHint
  module ActiveRecordHintMethods
    def hint(index_hint_by_table)
      thread_index_hint_by_table = (Thread.current[Arel::Visitors::MySQL::INDEX_HINT_BY_TABLE_THREAD_KEY] ||= {}.with_indifferent_access)
      thread_index_hint_by_table.update(index_hint_by_table)
      self
    end
  end
end
