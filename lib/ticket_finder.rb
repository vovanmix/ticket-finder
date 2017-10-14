dir = File.dirname(__FILE__) + '/ticket_finder'
Dir.glob(File.join(dir, '**', '*.rb'), &method(:require))

TicketFinder::Index::Index.build_index
TicketFinder::Console::Console.new.start
