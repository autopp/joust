require_relative '../show_tournament'

module Web::Views::Tournament
  class Show
    include Web::View

    include Web::Views::ShowTournament
  end
end
