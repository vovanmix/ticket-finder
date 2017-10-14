module TicketFinder
  module Console
    class ConsoleModule

      def initialize
        @steps = []
        @next_handler = nil
        @data = {}
      end

      # @return ConsoleResponse
      def perform_step
        result = step.perform(@data)
        @next_handler = result.next_handler unless result.next_handler.nil?
        result
      end

      # @return void
      def process_step(input)
        result = step.process(input, @data)
        @next_handler = result.next_handler unless result.next_handler.nil?
        @data[result.key] = result.value unless result.key.nil?
      end

      # @return ConsoleModule
      def next!
        return @next_handler unless @next_handler.nil?
        @steps.shift
        return nil if @steps.empty?
        self
      end

      private

      def step
        @steps.first
      end

    end
  end
end
