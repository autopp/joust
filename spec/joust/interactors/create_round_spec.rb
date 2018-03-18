describe Interactors::CreateRound do
  let(:interactor) do
    described_class.new(tournament_repo: tournament_repo, score_repo: score_repo)
  end

  let(:tournament_repo) { instance_double(TournamentRepository) }
  let(:score_repo) { instance_double(ScoreRepository) }

  subject { interactor.call(params) }

  shared_examples 'failure case' do
    it 'fails' do
      expect(subject).not_to be_a_success
      expect(subject.errors).not_to be_empty
    end
  end

  context 'when params are valid' do
    let(:tournament_id) { '1' }
    let(:params) { { tournament_id: tournament_id } }

    context 'when the tournament dose not exist' do
      before do
        allow(tournament_repo).to receive(:find).with(id: tournament_id).and_return(nil)
      end

      it_behaves_like 'failure case'
    end
  end

  context 'when params are invalid' do
    let(:params) { {} }

    it_behaves_like 'failure case'
  end
end
