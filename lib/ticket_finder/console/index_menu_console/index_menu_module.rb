require_relative '../console_module'

module TicketFinder
  module Console
    module IndexMenuConsole
      class IndexMenuModule < ::TicketFinder::Console::ConsoleModule

        def initialize
          super
          @steps = [IndexMenu.new]
        end

      end
    end
  end
end
