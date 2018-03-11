describe Interactors::CreateRound do
  let(:interactor) do
    described_class.new(tournament_repo: tournament_repo, score_repo: score_repo)
  end

  let(:tournament_repo) { instance_double(TournamentRepository) }
  let(:score_repo) { instance_double(ScoreRepository) }

  subject { interactor.call(params) }
end
