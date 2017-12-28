RSpec.describe Tournament, players: 7 do
  let(:tournament) { described_class.new(finished_count: finished_count, players: players) }

  describe '#ranking' do
    subject { tournament.ranking }

    context 'when finished round is one' do
      let(:finished_count) { 1 }

      it 'returns ranking from scores of round 1' do
        expect(subject).to eq(
          [
            { rank: 1, player: player1 },
            { rank: 2, player: player5 },
            { rank: 3, player: player2 },
            { rank: 4, player: player6 },
            { rank: 5, player: player3 },
            { rank: 6, player: player7 },
            { rank: 7, player: player4 }
          ]
        )
      end
    end
  end
end
