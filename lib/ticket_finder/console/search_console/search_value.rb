module TicketFinder
  module Console
    module SearchConsole
      class SearchValue

        def perform(_)
          ::TicketFinder::Console::ConsoleResponse.new(
            text: 'Enter search value',
            needs_answer: true
          )
        end

        def process(input, _)
          # cool but not needed
          # if input.empty?
          #   raise ::TicketFinder::Console::ValidationError
          #           .new('Please enter value')
          # end

          ::TicketFinder::Console::ProcessResult
            .new(key: :search_value, value: input)
        end

      end
    end
  end
end
