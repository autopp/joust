RSpec.describe Tournament, players: 7 do
  let(:tournament) { described_class.new(finished_count: finished_count, players: players) }

  describe '#ranking' do
    subject { tournament.ranking }

    context 'when finished round is one' do
      let(:finished_count) { 1 }

      it 'returns ranking from scores of round 1' do
        expect(subject).to eq(
          [
            [1, player1],
            [2, player5],
            [3, player2],
            [4, player6],
            [5, player3],
            [6, player7],
            [7, player4]
          ]
        )
      end
    end
  end
end
