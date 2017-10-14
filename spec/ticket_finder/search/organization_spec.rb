describe TicketFinder::Search::Organization do
  before do
    allow_any_instance_of(TicketFinder::Database).to receive(:read_index).and_return({})
    allow_any_instance_of(TicketFinder::Database).to receive(:read_db).and_return([])
    allow_any_instance_of(TicketFinder::Search::Search).to receive(:search_by).and_return(results)
  end

  let(:subject) { described_class.new(data) }

  let(:data) do
    {
      '_id' => 1,
      'name' => 'name'
    }
  end

  let(:results) do
    [
      {
        'subject' => 'subject1',
        'name' => 'name1'
      },
      {
        'subject' => 'subject2',
        'name' => 'name2'
      }
    ]
  end

  describe '#tickets' do
    context 'if tickets are NOT present' do
      let(:results) { [] }

      it 'returns "not found"' do
        expect(subject.tickets).to eq('not found')
      end
    end

    context 'if tickets are present' do
      it 'returns subjects of all tickets' do
        expect(subject.tickets).to eq(['subject1', 'subject2'])
      end
    end
  end

  describe '#users' do
    context 'if users are NOT present' do
      let(:results) { [] }

      it 'returns "not found"' do
        expect(subject.users).to eq('not found')
      end
    end

    context 'if users are present' do
      it 'returns names of all users' do
        expect(subject.users).to eq(['name1', 'name2'])
      end
    end
  end
end
