module Web::Controllers::Tournament
  class Show
    include Web::Action

    expose :tournament

    def initialize(interactor: Interactors::FindTournament.new)
      @interactor = interactor
    end

    def call(params)
      result = @interactor.call(id: params[:id])
      if result.success?
        @tournament = result.tournament
      else
        self.status = 400
        @errors = result.errors
      end
    end
  end
end
