module Web::Views::Round
  class Show
    include Web::View

    def title
      "#{tournament.name}: Round #{round.number}"
    end

    def back_path
      Web.routes.path(:tournament, tournament.id)
    end
  end
end
