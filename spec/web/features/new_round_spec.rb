require 'features_helper'

feature 'Create new round' do
  before do
    players = <<~INPUT
      player1
      player2
      player3
      player4
    INPUT
    input = {
      tournament: {
        name: 'My Tournament', players: players,
        total_vp_used: true, rank_history_used: true
      }
    }
    result = Interactors::CreateTournament.new.call(input)
    @id = result.tournament.id
  end

  scenario 'Visit a tournament page and create new round' do
    pending
    visit Web.routes.path(:tournament, id: @id)
    click_on 'Start new round'

    expect(current_path).to match(%r{/tournaments/#{@id}/rounds/\d+/edit})
  end
end
