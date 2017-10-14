describe TicketFinder::Index::Index do
  describe '.build_index' do
    before do
      allow(STDOUT).to receive(:puts)
    end

    context 'when index already exists' do
      before do
        allow_any_instance_of(TicketFinder::Database)
          .to receive(:index_exist?).and_return(true)

        stub_const('TicketFinder::DATABASES', [:users])
      end

      it 'prints a message' do
        expect(STDOUT).to receive(:puts).with('index already exist for users').once

        described_class.build_index
      end

      it 'does not index the database' do
        expect_any_instance_of(TicketFinder::Index::IndexBuilder).to_not receive(:build)

        described_class.build_index
      end
    end

    context 'when index does not exist' do
      before do
        allow_any_instance_of(TicketFinder::Database)
          .to receive(:index_exist?).and_return(false)
      end

      context 'when database is missing' do
        before do
          allow_any_instance_of(TicketFinder::Index::IndexBuilder)
            .to receive(:build).and_raise(TicketFinder::DatabaseMissing)

          stub_const('TicketFinder::DATABASES', [:users])
        end

        it 'prints a message' do
          expect(STDOUT).to receive(:puts).with('FATAL: database missing for users').once

          begin
            described_class.build_index
          rescue SystemExit; end
        end

        it 'stops execution' do
          expect { described_class.build_index }.to raise_error(SystemExit)
        end
      end

      context 'when database is present' do
        before do
          allow_any_instance_of(TicketFinder::Database)
            .to receive(:read_db).and_return([{ a: 1 }])
          allow_any_instance_of(TicketFinder::Database)
            .to receive(:write_index)
          allow_any_instance_of(TicketFinder::Index::IndexBuilder)
            .to receive(:build)

          stub_const('TicketFinder::DATABASES', [:users, :tickets])
        end

        it 'calls index on all databases' do
          expect(TicketFinder::Database)
            .to receive(:new).with(:users).and_call_original
          expect(TicketFinder::Database)
            .to receive(:new).with(:tickets).and_call_original

          expect(TicketFinder::Index::IndexBuilder)
            .to receive(:new).with([{ a: 1 }]).twice.and_call_original

          described_class.build_index
        end
      end
    end
  end
end
