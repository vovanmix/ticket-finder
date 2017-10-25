module TicketFinder
  module Search
    class IncorrectFormatter < StandardError; end

    class ResultsFormatter

      MARGIN = 20
      DELIMITER = '-------------'.freeze

      def initialize(db_name, results)
        @db_name, @results = db_name, results
      end

      def format
        @results.map { |result|
          model = make_model(result)
          model.fields.map { |field|
            format_field(field, model.send(field))
          }.join("\n")
        }.join("\n#{DELIMITER}\n")
      end

      private

      def format_field(field, value)
        label = field.to_s.ljust(MARGIN)
        value = format_value(value)
        "#{label}#{value}"
      end

      def format_value(value)
        if value.is_a?(Enumerable)
          format_array(value)
        else
          format_string(value)
        end
      end

      def format_array(value)
        "\n" +
          value
            .map(&method(:format_string))
            .map { |line| "#{' '.rjust(MARGIN)}* #{line}" }
            .join("\n")
      end

      def format_string(value)
        value
      end

      def make_model(result)
        case @db_name
        when :organizations
          Organization.new(result)
        when :users
          User.new(result)
        when :tickets
          Ticket.new(result)
        when :accounts
          Model.new(result)
        else
          raise IncorrectFormatter.new
        end
      end

    end
  end
end
