module TicketFinder
  module Console
    module SearchConsole
      class SearchField

        def perform(_)
          ::TicketFinder::Console::ConsoleResponse.new(
            text: 'Enter search term',
            needs_answer: true
          )
        end

        def process(input, data)
          fields = available_fields(data[:search_type])

          unless fields.include?(input)
            raise ::TicketFinder::Console::ValidationError
                    .new('This field does not exist!')
          end

          ::TicketFinder::Console::ProcessResult
            .new(key: :search_field, value: input)
        end

        private

        def available_fields(db_name)
          TicketFinder::Search::Search
            .instance(db_name)
            .available_fields
        end

      end
    end
  end
end
