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
      tournament_id = params[:tournament_id].to_i
      id = params[:id].to_i
      result = @drop_player.call(tournament_id: tournament_id, id: id)
      if result.success?
        @player = result.player
      else
        @errors = result.errors
        self.status = 400
      end
      result = @find_tournament.call(id: tournament_id)
      @tournament = result.tournament
    end
  end
end
