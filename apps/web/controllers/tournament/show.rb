module Web::Controllers::Tournament
  class Show
    include Web::Action

    expose :tournament

    def initialize(interactor: Interactors::FindTournament.new)
      @interactor = interactor
    end

    def call(params)
      result = @interactor.call(id: params[:id])
      unless result.success?
        raise 'failure'
      end
      @tournament = result.tournament
    end
  end
end
