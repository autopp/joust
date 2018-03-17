require 'hanami/interactor'

module Interactors
  class CreateRound
    include Hanami::Interactor

    def initialize(tournament_repo: TournamentRepository.new, score_repo: ScoreRepository)
      @tournament_repo = tournament_repo
      @score_repo = score_repo
    end

    def call(_params)
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
        required(:tournament_id) { format?(/\A[0-9]+\z/) }
      end
    end
  end
end
