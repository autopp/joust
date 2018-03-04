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
      r = @find_tournament.call(id: params[:tournament_id])
      player = @player_repo.find(params[:id])

      if !r.success?
        error("tournament #{params[:tournament_id]} dose not exist")
      elsif !player
        error("player #{params[:id]} dose not exist")
      elsif player.tournament_id != params[:tournament_id]
        error('player is not related to the tournament')
      elsif r.tournament.ongoing_round
        error('cannot drop player when ongoing round exist')
      else
        @player_repo.update(params[:id], droped_round: r.tournament.finished_count)
        @player = player
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
