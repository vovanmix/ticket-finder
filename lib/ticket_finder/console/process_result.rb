module TicketFinder
  module Console
    class ProcessResult

      attr_reader :key, :value, :next_handler

      def initialize(key: nil, value: nil, next_handler: nil)
        @key = key
        @value = value
        @next_handler = next_handler
      end

    end
  end
end
