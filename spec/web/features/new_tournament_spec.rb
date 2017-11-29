require 'features_helper'

feature 'Create New Tournament' do
  scenario 'Visit create page' do
    visit Web.routes.path(:root)
    click_on 'New Tournament'
    expect(current_path).to eq('/tournaments/new')
  end
end
