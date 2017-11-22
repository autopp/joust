module Web::Controllers::Tournament
  class Create
    include Web::Action

    def initialize(interactor: Interactors::Tournament.new)
      @interactor = interactor
    end

    def call(params)
      result = @interactor.call(params)
      @tournament = result.tournament
      redirect_to routes.path(:tournament, id: @tournament.id)
    end
  end
end
