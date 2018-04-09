describe Interactors::DropPlayer do
  let(:interactor) do
    described_class.new(find_tournament: find_tournament, player_repo: player_repo)
  end
  let(:find_tournament) { instance_double(Interactors::FindTournament) }
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
    let(:tournament) do
      double(
        'Tournament',
        id: 1, name: 'My Tournament', finished_count: 3,
        ongoing_round_number: ongoing_round_number, players: players
      )
    end

    let(:ongoing_round_number) { nil }
    let(:players) { [player] }
    let(:player) { Player.new(id: 2, tournament_id: tournament_id, name: 'foo') }
    let(:tournament_id) { 1 }
    let(:success) { true }

    before do
      result = double('FindTournament result')
      allow(result).to receive(:tournament).and_return(tournament)
      allow(result).to receive(:success?).and_return(success)
      allow(find_tournament).to receive(:call).with(id: 1).and_return(result)
      allow(player_repo).to receive(:find).with(2).and_return(player)
    end

    context 'when ongoing round dose not exist' do
      before do
        expect(player_repo).to receive(:update).with(2, droped_round: 3)
      end

      it { is_expected.to be_a_success }

      it 'exposes the player' do
        expect(subject.player).to eq(player)
      end
    end

    context 'when ongoing round exists' do
      let(:ongoing_round_number) { 2 }

      it_behaves_like 'failure case'
    end

    context 'when tournament dose not exist' do
      let(:tournament) { nil }
      let(:success) { false }

      it_behaves_like 'failure case'
    end

    context 'when player is not related to the tournament' do
      let(:players) { [] }

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
