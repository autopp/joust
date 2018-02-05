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
  end
end
