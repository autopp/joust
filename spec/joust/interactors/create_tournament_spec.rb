describe Interactors::CreateTournament do
  let(:interactor) { described_class.new(repo: repo) }
  let(:repo) { double('TournamentRepository') }
  let(:name) { 'My Tournament' }
  let(:players_count) { 4 }
  let(:params) do
    players = (1..players_count).map { |n| "player#{n}" }.join("\n")
    { tournament: { name: name, players: players, total_vp_used: '0', rank_history_used: '1' } }
  end
  subject { interactor.call(params) }

  context 'when parameters are valid' do
    let(:tournament) do
      players = (1..4).map { |i| Player.new(id: i, name: "player#{i}", tournament_id: 1) }
      Tournament.new(id: 1, name: name, players: players)
    end

    before do
      args = including(
        name: name, total_vp_used: '0', rank_history_used: '1',
        players: [
          { name: 'player1' }, { name: 'player2' }, { name: 'player3' }, { name: 'player4' }
        ]
      )
      expect(repo).to receive(:create_with_players).with(args).once.and_return(tournament)
    end

    it { is_expected.to be_a_success }

    it 'exposes the tournament created' do
      expect(subject.tournament).to eq(tournament)
    end
  end

  shared_examples 'failure by validations' do
    it { is_expected.not_to be_a_success }

    it 'generates error messages' do
      expect(subject.errors).not_to be_empty
    end

    it 'dose not create entity' do
      expect(repo).not_to receive(:create_with_players)
      subject
    end
  end

  context 'when count of players is 0' do
    let(:players_count) { 0 }
    it_behaves_like 'failure by validations'
  end

  context 'when count of players is 1' do
    let(:players_count) { 1 }
    it_behaves_like 'failure by validations'
  end

  context 'when count of players is 2' do
    let(:players_count) { 2 }
    it_behaves_like 'failure by validations'
  end

  context 'when count of players is 5' do
    let(:players_count) { 5 }
    it_behaves_like 'failure by validations'
  end

  context 'name is empty' do
    let(:name) { '' }
    it_behaves_like 'failure by validations'
  end
end
