require 'spec_helper'

describe Web.routes do
  it 'generates "/"' do
    expect(described_class.path(:root)).to eq('/')
  end
end
