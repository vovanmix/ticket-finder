describe TicketFinder::Search::Model do
  before do
    allow_any_instance_of(TicketFinder::Database).to receive(:read_index).and_return({})
    allow_any_instance_of(TicketFinder::Database).to receive(:read_db).and_return([])
  end

  let(:subject) { described_class.new(data) }

  let(:data) do
    {
      '_id' => 1,
      'name' => 'name'
    }
  end

  describe 'fields' do
    it 'returns all fields passed in' do
      expect(subject.fields).to eq(['_id', 'name'])
    end
  end

  describe 'properties' do
    it 'allow access to fields as instance properties' do
      expect(subject._id).to eq(1)
      expect(subject.name).to eq('name')
    end

    it 'returns "none" if the field is missing' do
      expect(subject.unknown).to eq('none')
    end
  end
end
