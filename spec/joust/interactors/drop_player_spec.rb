describe Interactors::DropPlayer do
  let(:interactor) do
    described_class.new(tournament_repo: tournament_repo, player_repo: player_repo)
  end
  let(:tournament_repo) { instance_double(TournamentRepository) }
  let(:player_repo) { instance_double(PlayerRepository) }

  subject { interactor.call(params) }

  let(:params) { { tournament_id: 1, id: 2 } }

  shared_examples 'failure case' do
    it { is_expected.not_to be_a_success }

    it 'generates error messages' do
      expect(subject.errors).not_to be_empty
    end

    it 'dose not update any player' do
      expect(player_repo).not_to receive(:update)
      subject
    end
  end

  context 'when given parameters are valid' do
    let(:tournament) { double('Tournament', id: 1, name: 'My Tournament', finished_count: 3) }

    before do
      allow(tournament_repo).to receive(:find).with(1).and_return(tournament)
    end

    context 'when ongoing round dose not exist' do
      before do
        allow(tournament).to receive(:ongoing_round).and_return(nil)
        expect(player_repo).to receive(:update).with(2, droped_round: 3)
      end

      it { is_expected.to be_a_success }
    end

    context 'when ongoing round exists' do
      before do
        round = Round.new(id: 4, tournament_id: 1, number: 4)
        allow(tournament).to receive(:ongoing_round).and_return(round)
      end

      it_behaves_like 'failure case'
    end
  end

  context 'when tournament_id is not given' do
    let(:params) { { id: 2 } }

    it_behaves_like 'failure case'
  end

  context 'when id is not given' do
    let(:params) { { tournament_id: 1 } }

    it_behaves_like 'failure case'
  end
end
