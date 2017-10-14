require 'rspec'

dir = File.dirname(__FILE__) + '/../lib/ticket_finder'
Dir.glob(File.join(dir, '**', '*.rb'), &method(:require))
