RSpec.describe Web::Controllers::Round::Create, type: :action do
  let(:action) { described_class.new(create_round: create_round) }
  let(:create_round) { instance_double(Interactors::CreateRound) }

  let(:params) { { tournament_id: '1' } }
  let(:result) { double('result') }

  before do
    expected_args = satisfying { |o| o.to_h == params }
    allow(create_round).to receive(:call).with(expected_args).and_return(result)
  end

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
        'Location' => Web.routes.path(:round, tournament_id: 1, number: 2)
      )
    end

    it 'exposes the created round' do
      action.call(params)
      expect(action.exposures).to include(round: round)
    end
  end
end
