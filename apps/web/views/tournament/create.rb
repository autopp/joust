module Web::Views::Tournament
  class Create
    include Web::View

    include Web::Views::NewTournament
    template 'tournament/new'
  end
end
