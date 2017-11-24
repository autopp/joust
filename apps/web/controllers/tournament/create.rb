module Web::Controllers::Tournament
  class Create
    include Web::Action

    expose :tournament

    def initialize(interactor: Interactors::Tournament.new)
      @interactor = interactor
    end

    def call(params)
      result = @interactor.call(params)

      if result.succuess?
        @tournament = result.tournament
        redirect_to routes.path(:tournament, id: @tournament.id)
      else
        self.status = 400
      end
    end
  end
end
