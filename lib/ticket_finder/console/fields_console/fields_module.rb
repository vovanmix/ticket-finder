require_relative '../console_module'

module TicketFinder
  module Console
    module FieldsConsole
      class FieldsModule < ::TicketFinder::Console::ConsoleModule

        def initialize
          super
          @steps = [
            ::TicketFinder::Console::SearchConsole::SearchType.new,
            ValidFieldsDisplay.new
          ]
        end

      end
    end
  end
end
