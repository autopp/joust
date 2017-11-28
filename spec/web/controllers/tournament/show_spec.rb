require_relative '../../../../apps/web/controllers/tournament/show'

RSpec.describe Web::Controllers::Tournament::Show do
  let(:action) { described_class.new(repo: repo) }
  let(:params) { Hash[id: 1] }

  let(:tournament) { Tournament.new(id: 1, name: 'My Tournament') }
  let(:repo) do
    repo = double('repo')
    allow(repo).to receive(:find).with(1).and_return(tournament)
    repo
  end

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 200
  end

  it 'exposes tournament' do
    action.call(params)
    expect(action.exposures).to include(tournament: tournament)
  end
end
