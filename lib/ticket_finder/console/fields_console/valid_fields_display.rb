module TicketFinder
  module Console
    module FieldsConsole
      class ValidFieldsDisplay

        def perform(data)
          db_name = data[:search_type]
          fields = available_fields(db_name)
          ::TicketFinder::Console::ConsoleResponse.new(
            text: "Fields in #{db_name} are:\n" +
            fields.map { |f| " * #{f}" }.join("\n")
          )
        end

        private

        def available_fields(db_name)
          TicketFinder::Search::Search
            .instance(db_name)
            .available_fields
        end

      end
    end
  end
end
