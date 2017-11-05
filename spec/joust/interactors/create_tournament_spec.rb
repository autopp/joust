describe Interactors::CreateTournament do
  let(:interactor) { described_class.new(params, repo: repo) }
  let(:repo) { double('TournamentRepository') }
  let(:name) { 'My Tournament' }

  context 'when parameters are valid' do
    subject { interactor.call }

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
end
