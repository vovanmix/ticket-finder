module TicketFinder
  module Search
    class Organization < Model

      def additional_fields
        [:tickets, :users]
      end

      def tickets
        search = TicketFinder::Search::Search.instance(:tickets)
        tickets = search.search_by(:organization_id, self._id)

        return 'not found' if tickets.empty?
        tickets.map { |t| t['subject'] }
      end

      def users
        search = TicketFinder::Search::Search.instance(:users)
        users = search.search_by(:organization_id, self._id)

        return 'not found' if users.empty?
        users.map { |t| t['name'] }
      end

    end
  end
end
