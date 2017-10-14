describe TicketFinder::Console::Console do
  before do
    allow(STDOUT).to receive(:puts)

    allow_any_instance_of(TicketFinder::Database).to receive(:project_root).and_return(
      File.absolute_path(File.dirname(__FILE__) + '/../../test_support')
    )
  end

  describe 'quit' do
    it 'exits if quit is the first response' do
      expect(STDOUT).to receive(:puts).with('Thank you for using Zendesk Search!')

      allow(STDIN).to receive(:gets).and_return('quit')

      described_class.new.start
    end

    it 'exits if quit is the 2nd response' do
      expect(STDOUT).to receive(:puts).with('Thank you for using Zendesk Search!')

      allow(STDIN).to receive(:gets).and_return('1', 'quit')

      described_class.new.start
    end

    it 'exits if quit is the 3rd response' do
      expect(STDOUT).to receive(:puts).with('Thank you for using Zendesk Search!')

      allow(STDIN).to receive(:gets).and_return('1', '1', 'quit')

      described_class.new.start
    end

    it 'exits if quit is the 4th response' do
      expect(STDOUT).to receive(:puts).with('Thank you for using Zendesk Search!')

      allow(STDIN).to receive(:gets).and_return('1', '1', '_id', 'quit')

      described_class.new.start
    end
  end

  describe 'search' do
    context 'when results are present' do
      it 'performs search and includes all results with related records' do
        expect(STDOUT).to receive(:puts).with('Welcome to Zendesk Search')
        expect(STDOUT).to receive(:puts).with('Select 1) Users or 2) Tickets or 3) Organizations')
        expect(STDOUT).to receive(:puts).with('Enter search term')
        expect(STDOUT).to receive(:puts).with('Enter search value')
        expect(STDOUT).to receive(:puts).with(/Search results/) do |arg|
          expect(arg).to include('Francisca Rasmussen')
          expect(arg).to include('Multron')
          expect(arg).to include('A Problem in Russian Federation')
          expect(arg).to include('A Nuisance in Kiribati')
        end
        expect(STDOUT).to receive(:puts).with('Thank you for using Zendesk Search!')

        allow(STDIN).to receive(:gets).and_return('1', '1', '_id', '1', 'quit')

        described_class.new.start
      end

      it 'returns all results if there are more than 1 match' do
        expect(STDOUT).to receive(:puts).with(/Search results/) do |arg|
          expect(arg).to include('A Problem in Russian Federation')
          expect(arg).to include('A Nuisance in Kiribati')
        end
        expect(STDOUT).to receive(:puts).with('Thank you for using Zendesk Search!')

        allow(STDIN).to receive(:gets).and_return('1', '2', 'type', 'problem', 'quit')

        described_class.new.start
      end

      it 'searches by a missing key' do
        expect(STDOUT).to receive(:puts).with(/Search results/) do |arg|
          expect(arg).to include('A Nuisance in Kiribati')
        end

        allow(STDIN).to receive(:gets).and_return('1', '2', 'due_at', '', 'quit')

        described_class.new.start
      end
    end

    context 'when user provides incorrect input' do
      it 'does not allow incorrect choices' do
        expect(STDOUT).to receive(:puts).with('Please select either 1 or 2')

        allow(STDIN).to receive(:gets).and_return('8', 'quit')

        described_class.new.start
      end

      it 'does not allow incorrect databases' do
        expect(STDOUT).to receive(:puts).with('Please select either 1, 2 or 3')

        allow(STDIN).to receive(:gets).and_return('1', '9', 'quit')

        described_class.new.start
      end

      it 'does not allow incorrect fields' do
        expect(STDOUT).to receive(:puts).with('This field does not exist!')

        allow(STDIN).to receive(:gets).and_return('1', '2', 'unknown', 'quit')

        described_class.new.start
      end
    end

    context 'when no results' do
      it 'returns a correct message' do
        expect(STDOUT).to receive(:puts).with('No results found')

        allow(STDIN).to receive(:gets).and_return('1', '1', '_id', '9999', 'quit')

        described_class.new.start
      end
    end
  end

  describe 'fields' do
    it 'returns correct fields' do
      expect(STDOUT).to receive(:puts).with(/Fields in organizations are/) do |arg|
        expect(arg).to include('* _id')
        expect(arg).to include('* url')
        expect(arg).to include('* external_id')
        expect(arg).to include('* name')
        expect(arg).to include('* domain_names')
        expect(arg).to include('* created_at')
        expect(arg).to include('* details')
        expect(arg).to include('* shared_tickets')
        expect(arg).to include('* tags')
      end

      allow(STDIN).to receive(:gets).and_return('2', '3', 'quit')

      described_class.new.start
    end
  end
end
