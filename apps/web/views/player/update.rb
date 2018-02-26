require_relative '../show_tournament'

module Web::Views::Player
  class Update
    include Web::View

    include Web::Views::ShowTournament
    template 'tournament/show'
  end
end
