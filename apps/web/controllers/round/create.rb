module Web::Controllers::Round
  class Create
    include Web::Action

    def initialize(create_round: Interactors::CreateRound.new)
      @create_round = create_round
    end

    def call(params)
      result = @create_round.call(params)

      if result.success?
        @round = result.round
        path = routes.path(:round, tournament_id: @round.tournament_id, number: @round.number)
        redirect_to path
      else
        self.status = 400
        @errors = result.errors
      end
    end
  end
end
