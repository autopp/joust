RSpec.describe Web::Controllers::Round::Create, type: :action do
  let(:action) { described_class.new(create_round: create_round, find_tournament: find_tournament) }
  let(:create_round) { instance_double(Interactors::CreateRound) }
  let(:find_tournament) { instance_double(Interactors::FindTournament) }

  let(:params) { orig_params.dup }
  let(:orig_params) { { tournament_id: '1' } }
  let(:result) { double('result') }

  before do
    expected_args = satisfying { |o| o.to_h == orig_params }
    allow(create_round).to receive(:call).with(expected_args).and_return(result)
  end

  let(:tournament) { Tournament.new(id: 1) }
  before do
    find_result = double('result')
    allow(find_result).to receive(:success?).and_return(true)
    allow(find_result).to receive(:tournament).and_return(tournament)
    allow(find_tournament).to receive(:call).with(id: '1').and_return(find_result)
  end

  context 'when creating round succeeds' do
    let(:round) { Round.new(id: 2, tournament_id: 1, number: 2) }

    before do
      allow(result).to receive(:success?).and_return(true)
      allow(result).to receive(:round).and_return(round)
    end

    it 'redirects to "/tournaments/1/rounds/2/edit"' do
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

  context 'when creating round fails' do
    let(:errors) { ['error occurred'] }

    before do
      allow(result).to receive(:success?).and_return(false)
      allow(result).to receive(:errors).and_return(errors)
    end

    it 'fails' do
      response = action.call(params)
      expect(response[0]).to eq(400)
    end

    it 'exposes errors of the interactor' do
      action.call(params)
      expect(action.exposures).to include(errors: errors)
    end

    it 'exposes the tournament for view' do
      action.call(params)
      expect(action.exposures).to include(tournament: tournament)
    end
  end
end
