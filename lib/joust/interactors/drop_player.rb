require 'hanami/interactor'

module Interactors
  class DropPlayer
    include Hanami::Interactor

    def initialize(tournament_repo: TournamentRepository.new, player_repo: PlayerRepository.new)
      @tournament_repo = tournament_repo
      @player_repo = player_repo
    end

    def call(_)
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
