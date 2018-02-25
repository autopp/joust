module Web::Controllers::Player
  class Update
    include Web::Action

    expose :player
    expose :tournament

    def initialize(
      drop_player: Interactors::DropPlayer.new, find_tournament: Interactors::FindTournament.new
    )
      @drop_player = drop_player
      @find_tournament = find_tournament
    end

    def call(params)
      result = @drop_player.call(params)
      if result.success?
        @player = result.player
        result = @find_tournament.call(id: params[:tournament_id])
        @tournament = result.tournament
      else
        @errors = result.errors
        self.status = 400
      end
    end
  end
end
