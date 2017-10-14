module TicketFinder
  module Index
    class IndexExists < StandardError; end

    class Index

      class << self

        def build_index
          STDOUT.puts 'indexing databases...'
          ::TicketFinder::DATABASES.each do |db|
            begin
              index_db(db)
            rescue IndexExists
              STDOUT.puts "index already exist for #{db}"
            rescue ::TicketFinder::DatabaseMissing
              STDOUT.puts "FATAL: database missing for #{db}"
              exit
            end
          end
          STDOUT.puts 'indexing databases complete!'
        end

        private

        def index_db(name)
          db = ::TicketFinder::Database.new(name)
          raise IndexExists if db.index_exist?

          index = IndexBuilder.new(db.read_db).build
          db.write_index(index)
        end

      end

    end
  end
end
