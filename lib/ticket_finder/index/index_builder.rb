module TicketFinder
  module Index
    class IndexBuilder

      def initialize(db_records)
        @db_records = db_records
        @index = Hash.new { |h, k| h[k] = Hash.new { |h2, k2| h2[k2] = [] } }
      end

      def build
        @db_records
          .each_with_index(&method(:index_record))
          .each_with_index(&method(:index_missing_fields))
        @index
      end

      private

      def index_record(record, idx)
        record.each_key do |key|
          values_arr(record[key]).each do |value|
            @index[key][value] << idx
          end
        end
      end

      def values_arr(value)
        if value.is_a?(Enumerable)
          value
        else
          [value]
        end
      end

      def index_missing_fields(record, idx)
        @index.each_key do |key|
          @index[key][''] << idx unless record.key?(key)
        end
      end

    end
  end
end
