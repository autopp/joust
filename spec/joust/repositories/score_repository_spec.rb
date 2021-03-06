RSpec.describe ScoreRepository, type: :repository do
  let(:repo) { described_class.new }

  describe '#find_with_player_by_round_id', players: 7 do
    subject { repo.find_with_player_by_round_id(round_id) }
    let(:round_id) { 1 }

    let(:tournament) do
      Tournament.new(
        id: 1, name: 'My Tournament', finished_count: 0, players: players, rounds: rounds
      )
    end
    let(:scores_of_round1) { players.map { |p| p.scores.find { |s| s.round_id == round_id } } }

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

    it 'returns scores' do
      expected = scores_of_round1.map do |score|
        a_hash_including(id: a_value, created_at: a_value, updated_at: a_value, **score.to_h)
      end
      expect(subject.map(&:to_h)).to match(expected)
    end

    it 'returns with players' do
      expected = players.map do |player|
        player_hash = player.to_h
        player_hash.delete(:scores)
        a_hash_including(id: a_value, created_at: a_value, updated_at: a_value, **player_hash)
      end
      expect(subject.map { |score| score.player.to_h }).to match(expected)
    end
  end
end
