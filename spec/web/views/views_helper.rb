shared_examples 'common view' do |title|
  it 'provides title' do
    expect(view.title).to eq(title)
  end
end
