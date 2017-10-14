module TicketFinder
  module Console
    class ConsoleStepResult

      attr_reader :quit, :next_handler

      def initialize(quit: false, next_handler: nil)
        @quit, @next_handler, @text = quit, next_handler
      end

    end
  end
end
