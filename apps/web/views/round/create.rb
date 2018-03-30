require_relative '../show_tournament'

module Web::Views::Round
  class Create
    include Web::View

    include Web::Views::ShowTournament
    template 'tournament/show'
  end
end
