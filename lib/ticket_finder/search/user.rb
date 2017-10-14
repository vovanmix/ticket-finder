module TicketFinder
  module Search
    class User < Model

      def additional_fields
        [:organization, :assigned_tickets, :submitted_tickets]
      end

      def organization
        search = TicketFinder::Search::Search.instance(:organizations)
        org = search.search_by(:_id, self.organization_id)

        return 'not found' if org.first.nil?
        org.first['name']
      end

      def assigned_tickets
        search = TicketFinder::Search::Search.instance(:tickets)
        tickets = search.search_by(:assignee_id, self._id)

        return 'not found' if tickets.empty?
        tickets.map { |t| t['subject'] }
      end

      def submitted_tickets
        search = TicketFinder::Search::Search.instance(:tickets)
        tickets = search.search_by(:submitter_id, self._id)

        return 'not found' if tickets.empty?
        tickets.map { |t| t['subject'] }
      end

    end
  end
end
