require 'spec_helper'

describe Web.routes do
  it 'generates "/"' do
    expect(described_class.path(:root)).to eq('/')
  end

  it 'generates "/tournaments"' do
    expect(described_class.path(:tournaments)).to eq('/tournaments')
  end

  it 'generates "/tournament/1"' do
    expect(described_class.path(:tournament, id: 1)).to eq('/tournament/1')
  end

  it 'generates "/tournament/new"' do
    expect(described_class.path(:new_tournament)).to eq('/tournament/new')
  end
end
