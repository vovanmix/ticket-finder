module TicketFinder
  module Console
    class ValidationError < StandardError; end

    class Console

      def initialize
        @handler = initial_module
      end

      def start
        greetings!

        begin
          response = @handler.perform_step
          STDOUT.puts response.text
          result = handle_response(response)
          @handler = result.next_handler if result.next_handler
        end until result.quit

        byebye!
      end

      private

      # @return ConsoleModule
      def initial_module
        IndexMenuConsole::IndexMenuModule.new
      end

      # @return ConsoleStepResult
      def handle_response(response)
        ConsoleStepResult.new(
          quit: response.needs_answer ? process_answer : false,
          next_handler: @handler.next! || initial_module
        )
      end

      # @return boolean
      def process_answer
        cmd = STDIN.gets.chomp
        return true if cmd == 'quit'

        @handler.process_step(cmd)
        false
      rescue ValidationError => e
        STDOUT.puts e.message
        return process_answer
      end

      # @return void
      def greetings!
        STDOUT.puts 'Welcome to Zendesk Search'
        STDOUT.puts "To exit, type 'quit' at any time."
      end

      # @return void
      def byebye!
        STDOUT.puts 'Thank you for using Zendesk Search!'
      end

    end
  end
end
