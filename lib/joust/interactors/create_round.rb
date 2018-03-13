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
  end
end
