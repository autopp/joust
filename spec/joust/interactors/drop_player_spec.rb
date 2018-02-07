describe Interactors::DropPlayer do
  let(:interactor) do
    described_class.new(tournament_repo: tournament_repo, player_repo: player_repo)
  end
  let(:tournament_repo) { instance_double(TournamentRepository) }
  let(:player_repo) { instance_double(PlayerRepository) }

  subject { interactor.call(params) }

  let(:params) { { tournament_id: 1, id: 2 } }

  context 'when given parameters are valid' do
    before do
      t = Tournament.new(
        id: 1, name: 'My Tournament', finished_count: 3
      )
      allow(tournament_repo).to receive(:find).with(1).and_return(t)
      expect(player_repo).to receive(:update).with(2, droped_round: 3)
    end

    it { is_expected.to be_a_success }
  end

  shared_examples 'failure by validations' do
    it { is_expected.not_to be_a_success }

    it 'generates error messages' do
      expect(subject.errors).not_to be_empty
    end

    it 'dose not update any player' do
      expect(player_repo).not_to receive(:update)
      subject
    end
  end

  context 'when tournament_id is not given' do
    let(:params) { { id: 2 } }

    it_behaves_like 'failure by validations'
  end

  context 'when id is not given' do
    let(:params) { { tournament_id: 1 } }

    it_behaves_like 'failure by validations'
  end
end
