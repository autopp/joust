describe TournamentRepository do
  let(:repo) { described_class.new }

  describe '#create_with_players' do
    subject do
      repo.create_with_players(
        name: 'My Tournament', total_vp_used: true, rank_history_used: true,
        player_names: %w[player1 player2 player3 player4]
      )
    end

    it 'returns created tournament players' do
      pending
      expected = {
        name: 'My Tournament', total_vp_used: true, rank_history_used: true,
        players: [
          { name: 'player1' }, { name: 'player2' }, { name: 'player3' }, { name: 'player4' }
        ]
      }
      expect(subject.to_h).to include(expected)
    end
  end
end
