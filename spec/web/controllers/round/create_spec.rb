RSpec.describe Web::Controllers::Round::Create, type: :action do
  let(:action) { described_class.new(create_round: create_round) }
  let(:interactor) { instance_double(Interactors::CreateRound) }

  let(:params) { { tournament_id: '1' } }
  let(:result) { double('result') }

  before { allow(interactor).to receive(:call).with(params).and_return(result) }

  context 'when creating round succeeds' do
    let(:round) { Round.new(id: 2, tournament_id: 1, number: 2) }

    before do
      allow(result).to receive(:success?).and_return(true)
      allow(result).to receive(:round).and_return(round)
    end

    it 'redirects to "/tournaments/1/rounds/2"' do
      response = action.call(params)
      expect(response[0]).to eq(302)
      expect(response[1]).to include(
        'Location' => Web.routes.path(:round_path, tournament_id: 1, id: 2)
      )
    end

    it 'exposes the created round' do
      action.call(params)
      expect(action.exposures).to include(round: round)
    end
  end
end
