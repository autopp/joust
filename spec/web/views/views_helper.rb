shared_examples 'common view' do |title:, back_path:|
  it 'provides title' do
    expect(view.title).to eq(title)
  end

  it 'provides back link' do
    expect(view.back_path).to eq(back_path)
  end
end
