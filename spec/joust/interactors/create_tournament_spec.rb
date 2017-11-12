describe Interactors::CreateTournament do
  let(:interactor) { described_class.new(params, repo: repo) }
  let(:repo) { double('TournamentRepository') }
  let(:name) { 'My Tournament' }
  subject { interactor.call }

  context 'when parameters are valid' do
    let(:params) do
      {
        name: name, players: "player1\nplayer2\nplayer3\nplayer4\n",
        total_vp_used: '0', rank_history_used: '1'
      }
    end

    let(:tournament) do
      Tournament.new(id: 1, name: name)
    end

    before do
      args = including(
        name: name, player_names: %w[player1 player2 player3 player4],
        total_vp_used: '0', rank_history_used: '1'
      )
      expect(repo).to receive(:create_with_players).with(args).once.and_return(tournament)
    end

    it { is_expected.to be_a_success }

    it 'exposes the tournament created' do
      expect(subject.tournament).to eq(tournament)
    end
  end

  shared_examples 'failure by players count' do |players_count|
    let(:params) do
      players = Array.new(players_count) { |n| "player#{n}" }.join("\n")
      { name: name, players: players, total_vp_used: '0', rank_history_used: '1' }
    end

    before { expect(repo).not_to receive(:create_with_players) }

    it { is_expected.not_to be_a_success }
  end

  context 'when count of players is 0' do
    it_behaves_like 'failure by players count', 0
  end

  context 'when count of players is 1' do
    it_behaves_like 'failure by players count', 1
  end

  context 'when count of players is 2' do
    it_behaves_like 'failure by players count', 2
  end

  context 'when count of players is 5' do
    it_behaves_like 'failure by players count', 5
  end
end
