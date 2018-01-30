require 'spec_helper'

describe 'Web.routes' do
  let(:routes) { Web.routes }

  it 'generates "/"' do
    expect(routes.path(:root)).to eq('/')
  end

  it 'generates "/tournaments"' do
    expect(routes.path(:tournaments)).to eq('/tournaments')
  end

  it 'generates "/tournaments/1"' do
    expect(routes.path(:tournament, id: 1)).to eq('/tournaments/1')
  end

  it 'generates "/tournaments/new"' do
    expect(routes.path(:new_tournament)).to eq('/tournaments/new')
  end

  it 'generates "/tournaments/:id/rounds/:number"' do
    expected = '/tournaments/1/rounds/2'
    expect(routes.path(:round, tournament_id: 1, number: 2)).to eq(expected)
  end

  it 'generates "/tournaments/:id/rounds/:number/edit"' do
    expected = '/tournaments/1/rounds/2/edit'
    expect(routes.path(:edit_round, tournament_id: 1, number: 2)).to eq(expected)
  end

  it 'generates "/tournaments/:tournament_id/players/:id"' do
    expected = '/tournaments/1/players/2'
    expect(routes.path(:player, tournament_id: 1, id: 2)).to eq(expected)
  end
end
