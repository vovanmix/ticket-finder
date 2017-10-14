describe TicketFinder::Search::Search do
  before do
    allow_any_instance_of(TicketFinder::Database).to receive(:read_index).and_return(index)
    allow_any_instance_of(TicketFinder::Database).to receive(:read_db).and_return(source)
    TicketFinder::Search::Search.clear_instances_cache
  end

  describe '.instance' do
    let(:index) { {} }
    let(:source) { [] }

    context 'when no instance exist for the database searcher' do
      it 'instantiates the database searcher' do
        expect(TicketFinder::Database).to receive(:new).and_call_original

        described_class.instance(:users)
      end
    end

    context 'when instance already exist for the database searcher' do
      it 'returns the existing copy the database searcher' do
        described_class.instance(:users)

        expect(TicketFinder::Database).to_not receive(:new)

        described_class.instance(:users)
      end
    end
  end

  describe '#search_by' do
    context 'when the field is missing from the index' do
      let(:index) { {} }
      let(:source) { [] }

      it 'returns empty array' do
        expect(
          described_class.instance(:users)
            .search_by(:a, 1)
        ).to eq([])
      end
    end

    context 'when no records exits in index for the field' do
      let(:index) { { 'a' => { '2' => [0] } } }
      let(:source) { [] }

      it 'returns empty array' do
        expect(
          described_class.instance(:users)
            .search_by(:a, 1)
        ).to eq([])
      end
    end

    context 'when records exits in index' do
      let(:index) { { 'a' => { '1' => [0, 1] } } }
      let(:source) { ['a', 'b'] }

      it 'returns array of results' do
        expect(
          described_class.instance(:users)
            .search_by(:a, 1)
        ).to eq(['a', 'b'])
      end
    end
  end

  describe '#available_fields' do

  end

end
