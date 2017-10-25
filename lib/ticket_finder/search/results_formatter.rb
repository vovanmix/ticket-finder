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
          fields = make_model(result)
          fields.each_key.map { |field_name|
            format_field(field_name, fields[field_name])
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
        # read json

        # go over all fields
        # include relations

        # case @db_name
        # when :organizations
        #   Organization.new(result)
        # when :users
        #   User.new(result)
        # when :tickets
        #   Ticket.new(result)
        # when :accounts
        #   Model.new(result)
        # else
        #   raise IncorrectFormatter.new
        # end
      end

      

      def read_schema
        raise SchemaMissing unless db_exist?
        ::JSON.parse(File.read(schema_file_path))
      end

      def schema_file_path
        "#{project_root}/index/schema.json"
      end

      def project_root
        File.absolute_path(File.dirname(__FILE__) + '/../..')
      end

    end
  end
end
