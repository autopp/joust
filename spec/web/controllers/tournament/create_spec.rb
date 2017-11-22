RSpec.describe Web::Controllers::Tournament::Create, type: :action do
  let(:action) { described_class.new(interactor: interactor) }
  let(:interactor) { instance_double(Interactors::CreateTournament) }
  let(:name) { 'My Tournament' }

  let(:params) do
    { name: name, players: players, total_vp_used: '0', rank_history_used: '1' }
  end

  context 'when parameters are valid' do
    let(:name) { 'My Tournament' }
    let(:players) { "player2\nplayer1\nplayer3\nplayer4\n" }
    let(:tournament) do
      Tournament.new(
        id: 1, name: name, total_vp_used: false, rank_history_used: true, finished_count: 0,
        players: (1..4).map { |i| Player.new(id: i, name: "player#{i}") }
      )
    end

    before do
      allow(interactor).to receive(:call).with(params).and_return(tournament)
    end

    it 'redirects to "/tournaments/1"' do
      response = action.call(params)
      expect(response[0]).to eq(302)
      expect(response[1]).to include('Location' => '/tournaments/1')
    end

    it 'exposes the created tournament'
  end

  context 'when parameters are invalid' do
    it 'is failure'
  end
end
