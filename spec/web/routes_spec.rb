require 'spec_helper'

describe Web.routes do
  it 'generates "/"' do
    expect(described_class.path(:root)).to eq('/')
  end

  it 'generates "/tournaments"' do
    expect(described_class.path(:tournaments)).to eq('/tournaments')
  end

  it 'generates "/tournaments/1"' do
    expect(described_class.path(:tournament, id: 1)).to eq('/tournaments/1')
  end

  it 'generates "/tournaments/new"' do
    expect(described_class.path(:new_tournament)).to eq('/tournaments/new')
  end

  it 'generates "/tournaments/:id/rounds/:number"' do
    expected = '/tournaments/1/rounds/2'
    expect(described_class.path(:round, tournament_id: 1, number: 2)).to eq(expected)
  end

  it 'generates "/tournaments/:id/rounds/:number/edit"' do
    expected = '/tournaments/1/rounds/2/edit'
    expect(described_class.path(:edit_round, tournament_id: 1, number: 2)).to eq(expected)
  end
end
