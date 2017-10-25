module TicketFinder
  module Console
    module SearchConsole
      class SearchType

        def perform(_)
          ::TicketFinder::Console::ConsoleResponse.new(
            text: 'Select 1) Users or 2) Tickets or 3) Organizations, 4) Accounts',
            needs_answer: true
          )
        end

        def process(input, _)
          case input
          when '1'
            ::TicketFinder::Console::ProcessResult
              .new(key: :search_type, value: :users)
          when '2'
            ::TicketFinder::Console::ProcessResult
              .new(key: :search_type, value: :tickets)
          when '3'
            ::TicketFinder::Console::ProcessResult
              .new(key: :search_type, value: :organizations)
          when '4'
            ::TicketFinder::Console::ProcessResult
              .new(key: :search_type, value: :accounts)
          else
            raise ::TicketFinder::Console::ValidationError
                    .new('Please select either 1, 2 or 3')
          end
        end

      end
    end
  end
end
