require_relative '../../../../apps/web/controllers/tournament/index'

RSpec.describe Web::Controllers::Tournament::Index do
  let(:action) { described_class.new(repo: repo) }
  let(:params) { Hash[] }

  let(:tournament) { Tournament.new(id: 1, name: 'My Tournament') }
  let(:repo) { double('repo', all: [tournament]) }

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 200
  end

  it 'exposes tournaments' do
    action.call(params)
    expect(action.exposures).to include(tournaments: [tournament])
  end
end
