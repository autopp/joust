module Web::Views::Tournament
  class Show
    include Web::View

    def title
      tournament.name
    end

    def back_path
      Web.routes.path(:tournaments)
    end
  end
end
