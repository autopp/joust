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

  describe '#find_with_attrs', players: 7 do
    let(:round1) { Round.new(id: 1, tournament_id: 1, number: 1) }
    let(:round2) { Round.new(id: 2, tournament_id: 1, number: 2) }
    let(:rounds) { [round1, round2] }
    let(:tournament) do
      Tournament.new(
        id: 1, name: 'My Tournament', finished_count: 0, players: players, rounds: rounds
      )
    end

    subject { repo.find_with_attrs(1) }

    before do
      repo.create(tournament.to_h)

      round_repo = RoundRepository.new
      rounds.each { |r| round_repo.create(r.to_h) }

      player_repo = PlayerRepository.new
      score_repo = ScoreRepository.new
      players.each do |p|
        player_repo.create(p.to_h)
        p.scores.each { |s| score_repo.create(s.to_h) }
      end
    end

    it 'returns tournament with players, rounds and scores' do
      expect(subject).to eq(tournament)
      expect(subject.rounds).to eq(rounds)
      expect(subject.players).to eq(players)
      expect(subject.players.map(&:scores)).to eq(players.map(&:scores))
    end
  end
end
