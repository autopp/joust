require_relative '../../../../apps/web/controllers/tournament/show'

RSpec.describe Web::Controllers::Tournament::Show do
  let(:action) { described_class.new }
  let(:params) { Hash[id: 1] }

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 200
  end
end
