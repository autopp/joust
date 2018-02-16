RSpec.describe Web::Controllers::Player::Update, type: :action do
  let(:action) { described_class.new(interactor: interactor) }
  let(:params) { { tournament_id: 1, id: 2 } }
  let(:interactor) { instance_double(Interactors::DropPlayer) }

  subject { action.call(params) }

  context 'when interactor succeeds' do
    let(:player) { Player.new(id: 2, tournament_id: 1, name: 'player1') }

    before do
      result = double('interactor result')
      allow(result).to receive(:success?).and_return(true)
      allow(result).to receive(:errors).and_return([])
      allow(result).to receive(:player).and_return(player)

      expected_args = satisfying { |o| o.to_h == params }
      allow(interactor).to receive(:call).with(expected_args).and_return(result)
    end

    it 'is successful' do
      expect(subject[0]).to eq 200
    end

    it 'exposes no error' do
      subject
      expect(action.exposures).not_to include(errors: [])
    end

    it 'exposes the player' do
      subject
      expect(action.exposures).to include(player: player)
    end
  end
end
