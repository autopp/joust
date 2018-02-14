require 'hanami/interactor'

module Interactors
  class DropPlayer
    include Hanami::Interactor

    expose :player

    def initialize(tournament_repo: TournamentRepository.new, player_repo: PlayerRepository.new)
      @tournament_repo = tournament_repo
      @player_repo = player_repo
    end

    def call(params)
      t = @tournament_repo.find(params[:tournament_id])
      player = @player_repo.find(params[:id])

      if !t
        error("tournament #{params[:tournament_id]} dose not exist")
      elsif !player
        error("player #{params[:id]} dose not exist")
      elsif player.tournament_id != params[:tournament_id]
        error('player is not related to the tournament')
      elsif t.ongoing_round
        error('cannot drop player when ongoing round exist')
      else
        @player_repo.update(params[:id], droped_round: t.finished_count)
        @player = player
      end
    end

    def valid?(params)
      result = Validator.new(params).validate
      if result.success?
        true
      else
        error(*result.errors)
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
