require_relative '../console_module'

module TicketFinder
  module Console
    module SearchConsole
      class SearchModule < ::TicketFinder::Console::ConsoleModule

        def initialize
          super
          @steps = [SearchType.new,
                    SearchField.new,
                    SearchValue.new,
                    SearchResults.new]
        end

      end
    end
  end
end
