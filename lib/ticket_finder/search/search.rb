module TicketFinder
  module Search
    class Search

      class << self

        @@instance = {}

        def instance(db_name)
          @@instance[db_name] ||= new(db_name)
        end

        def clear_instances_cache
          @@instance = {}
        end

        private_class_method :new

      end

      def initialize(db_name)
        @db = ::TicketFinder::Database.new(db_name)
        @index = @db.read_index
        @content = @db.read_db
      rescue ::TicketFinder::IncorrectDatabase
        STDOUT.puts "FATAL: incorrect database name: #{db_name}"
        exit
      rescue ::TicketFinder::IndexMissing
        STDOUT.puts "FATAL: missing index for #{db_name}"
        exit
      end

      def search_by(field, value)
        values = @index[field.to_s]
        return [] if values.nil?
        ids = values[value.to_s]
        return [] if ids.nil?

        ids.map { |id| @content[id] }
      rescue ::TicketFinder::DatabaseMissing
        STDOUT.puts "FATAL: missing database for #{db_name}"
        exit
      end

      def available_fields
        @index.keys
      end

    end
  end
end
