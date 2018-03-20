describe Interactors::CreateRound do
  let(:interactor) do
    described_class.new(
      tournament_repo: tournament_repo, score_repo: score_repo, find_tournament: find_tournament
    )
  end

  let(:tournament_repo) { instance_double(TournamentRepository) }
  let(:find_tournament) { instance_double(Interactors::FindTournament) }
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
    let(:find_result) { double('FindTournament result') }

    before do
      allow(find_tournament).to receive(:call).with(id: tournament_id).and_return(find_result)
    end

    context 'when the tournament dose not exist' do
      before do
        allow(find_result).to receive(:success?).and_return(false)
        allow(find_result).to receive(:errors).and_return(['error of FindTournament'])
      end

      it_behaves_like 'failure case'
    end

    context 'when the tournament exists' do
      let(:tournament) { double('tournament', id: tournament_id.to_i, name: 'MyTournament') }

      before do
        allow(find_result).to receive(:success?).and_return(true)
        allow(find_result).to receive(:tournament).and_return(tournament)
        allow(tournament).to receive(:ongoing_round).and_return(ongoing_round)
      end

      context 'when the tournament has ongoing round' do
        let(:ongoing_round) { instance_double(Round) }

        it_behaves_like 'failure case'
      end
    end
  end

  context 'when params are invalid' do
    let(:params) { {} }

    it_behaves_like 'failure case'
  end
end
