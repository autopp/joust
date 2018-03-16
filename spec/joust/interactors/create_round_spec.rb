describe Interactors::CreateRound do
  let(:interactor) do
    described_class.new(tournament_repo: tournament_repo, score_repo: score_repo)
  end

  let(:tournament_repo) { instance_double(TournamentRepository) }
  let(:score_repo) { instance_double(ScoreRepository) }

  subject { interactor.call(params) }

  context 'when params are valid' do
  end

  context 'when params are invalid' do
    let(:params) { {} }

    it 'fails' do
      expect(subject).not_to be_a_success
      expect(subject.errors).not_to be_empty
    end
  end
end
