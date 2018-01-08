RSpec.describe PlayerRepository, type: :repository do
  let(:repo) { PlayerRepository.new }

  describe '#find_with_scores_by_tournament_id', players: 7 do
    subject { repo.find_with_scores_by_tournament_id(1) }

    let(:round1) { Round.new(id: 1, tournament_id: 1, number: 1) }
    let(:round2) { Round.new(id: 2, tournament_id: 1, number: 2) }
    let(:rounds) { [round1, round2] }

    let(:tournament) do
      Tournament.new(
        id: 1, name: 'My Tournament', finished_count: 0, players: players, rounds: rounds
      )
    end

    before do
      TournamentRepository.new.create(tournament.to_h)

      round_repo = RoundRepository.new
      rounds.each { |r| round_repo.create(r.to_h) }

      player_repo = PlayerRepository.new
      score_repo = ScoreRepository.new
      players.each do |p|
        player_repo.create(p.to_h)
        p.scores.each { |s| score_repo.create(s.to_h) }
      end
    end

    it 'returns players with scores' do
      expect(subject).to eq(players)
      expected_scores = players.map(&:scores).map do |scores|
        scores.map do |score|
          a_hash_including(created_at: a_value, updated_at: a_value, **score.to_h)
        end
      end

      actual_scores = subject.map(&:scores).map { |scores| scores.map(&:to_h) }
      expect(actual_scores).to match(expected_scores)
    end
  end
end
