describe TicketFinder::Index::IndexBuilder do
  let(:subject) { described_class.new(records) }

  describe '#build' do
    context 'when all records have all fields' do
      let(:records) do
        [
          { a: 1,
            b: [1, 2] },
          { a: 1,
            b: [3, 2] },
          { a: 2,
            b: [2] }
        ]
      end

      it 'builds index for all records' do
        expect(subject.build).to eq(
          a: {
            1 => [0, 1],
            2 => [2]
          },
          b: {
            1 => [0],
            2 => [0, 1, 2],
            3 => [1]
          }
        )
      end
    end

    context 'when some records have some fields missing' do
      let(:records) do
        [
          { a: 1,
            b: [1, 2] },
          { a: 1 },
          { b: [2] }
        ]
      end

      it 'builds index for missing fields' do
        expect(subject.build).to eq(
          a: {
            1 => [0, 1],
            '' => [2]
          },
          b: {
            1 => [0],
            2 => [0, 2],
            '' => [1]
          }
        )
      end
    end
  end
end
