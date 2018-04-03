module Web::Controllers::Round
  class Create
    include Web::Action

    expose :round
    expose :tournament

    def initialize(
      create_round: Interactors::CreateRound.new,
      find_tournament: Interactors::FindTournament.new
    )
      @create_round = create_round
      @find_tournament = find_tournament
    end

    def call(params)
      result = @create_round.call(params)

      if result.success?
        @round = result.round
        path = routes.path(:edit_round, tournament_id: @round.tournament_id, number: @round.number)
        redirect_to path
      else
        self.status = 400
        @errors = result.errors
        @tournament = @find_tournament.call(id: params[:tournament_id]).tournament
      end
    end
  end
end
