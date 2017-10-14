Kernel.load 'lib/ticket_finder/version.rb'

Gem::Specification.new {|s|
	s.name         = 'ticket_finder'
	s.version      = TicketFinder.version
	s.author       = 'Vladimir Mikhaylovskiy'
	s.email        = 'singingcode@gmail.com'
	s.homepage     = 'http://github.com/vovanmix/ticket-finder'
	s.platform     = Gem::Platform::RUBY
	s.summary      = 'ticket finder'

	s.files         = `git ls-files`.split("\n")
	s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
	s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
	s.require_paths = ['lib']
}
