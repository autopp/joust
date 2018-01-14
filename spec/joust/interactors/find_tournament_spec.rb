describe Interactors::FindTournament do
  let(:interactor) do
    described_class.new(
      tournament_repo: tournament_repo, round_repo: round_repo, player_repo: player_repo
    )
  end
  let(:tournament_repo) { instance_double(TournamentRepository) }
  let(:player_repo) { instance_double(PlayerRepository) }
  let(:round_repo) { instance_double(RoundRepository) }

  let(:id) { 1 }

  subject { interactor.call(id: id) }

  context 'when tournament exists', players: 7 do
    let(:tournament) { Tournament.new(id: id, name: 'My Tournament', finished_count: 2) }

    before do
      allow(tournament_repo).to receive(:find).with(id).and_return(tournament)
      allow(player_repo).to receive(:find_with_scores_by_tournament_id).and_return(players)
      allow(round_repo).to receive(:find_with_scores_by_tournament_id).and_return(rounds)
    end

    it { is_expected.to be_a_success }

    it 'exposes a tournament with all entities' do
      tournament = subject.tournament
      expect(tournament).to eq(tournament)
      expect(tournament.players).to eq(players)
      expect(tournament.rounds).to eq(rounds)
      expect(tournament.players.map(&:scores)).to eq(players.map(&:scores))
      expect(tournament.rounds.map(&:scores)).to eq(rounds.map(&:scores))
    end
  end

  context 'when tournament dose not exist' do
    before do
      allow(tournament_repo).to receive(:find).with(id).and_return(nil)
    end

    it { is_expected.not_to be_a_success }

    it 'exposes a error messages' do
      expect(subject.errors).not_to be_empty
    end
  end
end
