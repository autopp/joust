require 'hanami/interactor'

module Interactors
  class DropPlayer
    include Hanami::Interactor

    expose :player

    def initialize(
      tournament_repo: TournamentRepository.new, player_repo: PlayerRepository.new
    )
      @tournament_repo = tournament_repo
      @player_repo = player_repo
    end

    def call(params)
      tournament_id = params[:tournament_id]
      id = params[:id]
      tournament = @tournament_repo.find(tournament_id)

      unless tournament
        error("tournament #{tournament_id} dose not exist")
        return
      end

      # @player = tournament.players.find { |p| p.id == id }
      @player = @player_repo.find(id)

      if !@player || @player.tournament_id != tournament_id
        error("player #{id} related to the tournament dose not exist")
      elsif tournament.ongoing_round_number
        error('cannot drop player when ongoing round exist')
      else
        @player_repo.update(id, droped_round: tournament.finished_count)
      end
    end

    def valid?(params)
      result = Validator.new(params).validate
      if result.success?
        true
      else
        result.errors.each { |e| error(e) }
        false
      end
    end

    class Validator
      include Hanami::Validations

      validations do
        required(:tournament_id) { int? }
        required(:id) { int? }
      end
    end
  end
end
