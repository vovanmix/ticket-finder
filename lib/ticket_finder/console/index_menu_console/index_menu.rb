module TicketFinder
  module Console
    module IndexMenuConsole
      class IndexMenu

        def perform(_)
          ::TicketFinder::Console::ConsoleResponse.new(
            text: "Select search options:\n"\
              " * Type 1 to search Zendesk\n"\
              " * Type 2 to view a list of searchable fields\n"\
              " * Type 'quit' to exit",
            needs_answer: true
          )
        end

        def process(input, _)
          case input
          when '1'
            ::TicketFinder::Console::ProcessResult.new(
              next_handler: ::TicketFinder::Console::SearchConsole::SearchModule.new
            )
          when '2'
            ::TicketFinder::Console::ProcessResult.new(
              next_handler: ::TicketFinder::Console::FieldsConsole::FieldsModule.new
            )
          else
            raise ::TicketFinder::Console::ValidationError.new('Please select either 1 or 2')
          end
        end

      end
    end
  end
end
