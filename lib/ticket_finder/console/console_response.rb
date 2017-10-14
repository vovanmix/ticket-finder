module TicketFinder
  module Console
    class ConsoleResponse

      attr_reader :text, :needs_answer, :next_handler

      def initialize(text:, needs_answer: false, next_handler: nil)
        @text = text
        @needs_answer = needs_answer
        @next_handler = next_handler
      end

    end
  end
end
