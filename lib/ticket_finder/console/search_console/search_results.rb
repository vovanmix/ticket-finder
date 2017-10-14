module TicketFinder
  module Console
    module SearchConsole
      class SearchResults

        def perform(data)
          db_name = data[:search_type]
          field = data[:search_field]
          value = data[:search_value]

          size, search_results = search(db_name, field, value)
          results = if search_results.empty?
                      'No results found'
                    else
                      "Search results (#{size}):\n#{search_results}"
                    end

          ::TicketFinder::Console::ConsoleResponse.new(text: results)
        end

        private

        def search(db_name, field, value)
          search = TicketFinder::Search::Search.instance(db_name)
          results = search.search_by(field, value)

          [
            results.size,
            TicketFinder::Search::ResultsFormatter.new(db_name, results).format
          ]
        end

      end
    end
  end
end
