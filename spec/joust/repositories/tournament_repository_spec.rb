describe TournamentRepository do
  let(:repo) { described_class.new }

  describe '#create_with_players' do
    let(:name) { 'My Tournament' }
    let(:players) do
      [{ name: 'player1' }, { name: 'player2' }, { name: 'player3' }, { name: 'player4' }]
    end

    subject do
      repo.create_with_players(
        name: name, total_vp_used: true, rank_history_used: true, players: players
      )
    end

    it 'returns created tournament with players' do
      expected = {
        name: 'My Tournament', total_vp_used: true, rank_history_used: true, finished_count: 0
      }
      expect(subject.to_h).to include(expected)
      expect(subject.players.map(&:name)).to eq(%w[player1 player2 player3 player4])
      expect(subject.players.map(&:tournament_id)).to all(eq(subject.id))
    end
  end

  describe '#add_round' do
    subject { repo.add_round(tournament) }
    let(:tournament) do
      Tournament.new(id: 1, name: 'My Tournament', finished_count: 1)
    end

    it 'returns created round' do
      expect(subject.to_h).to include(tournament_id: 1, number: 2)
    end
  end
end
