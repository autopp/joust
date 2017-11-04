describe Interactors::CreateTournament do
  let(:interactor) { described_class.new }

  it 'succeeds' do
    expect(interactor.call).to be_a_success
  end
end
