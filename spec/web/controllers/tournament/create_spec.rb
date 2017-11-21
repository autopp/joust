RSpec.describe Web::Controllers::Tournament::Create, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  context 'when parameters are valid' do
    it 'redirects to "/tournaments/1"'

    it 'exposes the created tournament'
  end

  context 'when parameters are invalid' do
    it 'is failure'
  end
end
