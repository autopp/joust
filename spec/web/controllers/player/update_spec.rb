RSpec.describe Web::Controllers::Player::Update, type: :action do
  let(:action) { described_class.new(interactor: interactor) }
  let(:params) { Hash[] }
  let(:interactor) { instance_double(Interactors::DropPlayer) }

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 200
  end
end
