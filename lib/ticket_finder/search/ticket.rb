module TicketFinder
  module Search
    class Ticket < Model

      def additional_fields
        [:organization, :assignee, :submitter]
      end

      def organization
        search = TicketFinder::Search::Search.instance(:organizations)
        org = search.search_by(:_id, self.organization_id)

        return 'not found' if org.first.nil?
        org.first['name']
      end

      def assignee
        search = TicketFinder::Search::Search.instance(:users)
        user = search.search_by(:_id, self.assignee_id)

        return 'not found' if user.first.nil?
        user.first['name']
      end

      def submitter
        search = TicketFinder::Search::Search.instance(:users)
        user = search.search_by(:_id, self.submitter_id)

        return 'not found' if user.first.nil?
        user.first['name']
      end

    end
  end
end
