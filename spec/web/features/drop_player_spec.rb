require 'features_helper'

require 'features_helper'

feature 'Drop player' do
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

  scenario 'Visit a tournament page and dropout' do
  end
end
