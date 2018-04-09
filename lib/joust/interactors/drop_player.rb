require 'hanami/interactor'

module Interactors
  class DropPlayer
    include Hanami::Interactor

    expose :player

    def initialize(
      find_tournament: Interactors::FindTournament.new, player_repo: PlayerRepository.new
    )
      @find_tournament = find_tournament
      @player_repo = player_repo
    end

    def call(params)
      id = params[:id]
      r = @find_tournament.call(id: params[:tournament_id])

      unless r.success?
        error("tournament #{params[:tournament_id]} dose not exist")
        return
      end

      tournament = r.tournament
      @player = tournament.players.find { |p| p.id == id }

      if !@player
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
