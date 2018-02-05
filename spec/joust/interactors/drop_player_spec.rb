describe Interactors::DropPlayer do
  let(:interactor) do
    described_class.new(tournament_repo: tournament_repo, player_repo: player_repo)
  end
  let(:tournament_repo) { instance_double(TournamentRepository) }
  let(:player_repo) { instance_double(PlayerRepository) }
end
