require_relative '../../../../apps/web/controllers/tournament/show'

RSpec.describe Web::Controllers::Tournament::Show, players: 7 do
  let(:action) { described_class.new(interactor: interactor) }
  let(:interactor) { instance_double(Interactors::FindTournament) }
  let(:params) { Hash[id: 1] }

  let(:tournament) do
    Tournament.new(id: 1, name: 'My Tournament', players: players, rounds: rounds)
  end

  context 'when tournament exist' do
    before do
      result = double('result')
      allow(result).to receive(:success?).and_return(true)
      allow(result).to receive(:tournament).and_return(tournament)

      allow(interactor).to receive(:call).with(id: 1).and_return(result)
    end

    it 'is successful' do
      response = action.call(params)
      expect(response[0]).to eq(200)
    end

    it 'exposes tournament' do
      action.call(params)
      expect(action.exposures).to include(tournament: tournament)
    end
  end

  context 'when tournament dose not exist' do
    let(:errors) { ['something wrong'] }

    before do
      result = double('result')
      allow(result).to receive(:success?).and_return(false)
      allow(result).to receive(:errors).and_return(errors)

      allow(interactor).to receive(:call).with(id: 1).and_return(result)
    end

    it 'is failure' do
      response = action.call(params)
      expect(response[0]).to eq 400
    end

    it 'exposes errors' do
      action.call(params)
      expect(action.exposures).to include(errors: errors)
    end
  end
end
