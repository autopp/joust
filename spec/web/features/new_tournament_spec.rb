require 'features_helper'

feature 'Create New Tournament' do
  scenario 'Visit create page' do
    visit Web.routes.path(:root)
    click_on 'New Tournament'
    expect(current_path).to eq('/tournaments/new')
  end

  scenario 'Create tournament by valid input' do
    players = <<~INPUT
      player1
      player2
      player3
      player4
    INPUT

    visit Web.routes.path(:new_tournament)
    fill_in 'tournament-name', with: 'My Tournament'
    fill_in 'tournament-players', with: players

    click_on 'Create'
    expect(current_path).to match(%r{/tournaments/\d+})
  end
end
