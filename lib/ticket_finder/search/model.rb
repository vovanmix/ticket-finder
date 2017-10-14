module TicketFinder
  module Search
    class Model

      def initialize(data)
        @data = data
      end

      def additional_fields
        []
      end

      def fields
        @data.keys + additional_fields
      end

      def method_missing(method, *args, &block)
        return 'none' unless @data.key?(method.to_s)

        @data[method.to_s]
      end

      def respond_to_missing?(_, *)
        true
      end

    end
  end
end
