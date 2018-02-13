RSpec.describe Web::Controllers::Player::Update, type: :action do
  let(:action) { described_class.new(interactor: interactor) }
  let(:params) { { tournament_id: 1, id: 2 } }
  let(:interactor) { instance_double(Interactors::DropPlayer) }

  context 'when interactor succeeds' do
    before do
      result = double('interactor result')
      allow(result).to receive(:success?).and_return(true)
      allow(result).to receive(:errors).and_return([])
      allow(interactor).to receive(:call).with(params).and_return(result)
    end

    it 'is successful' do
      response = action.call(params)
      expect(response[0]).to eq 200
    end

    it 'exposes no error' do
      action.call(params)
      expect(action.exposures).to include(errors: [])
    end
  end
end
