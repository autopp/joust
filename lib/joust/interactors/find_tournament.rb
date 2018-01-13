require 'hanami/interactor'

module Interactors
  class FindTournament
    include Hanami::Interactor

    expose :tournament

    def initialize(
      tournament_repo: TournamentRepository.new,
      player_repo: PlayerRepository.new, round_repo: RoundRepository.new
    )
      @tournament_repo = tournament_repo
      @player_repo = player_repo
      @round_repo = round_repo
    end

    def call(params)
      id = params[:id]
      tournament = @tournament_repo.find(id)
      unless tournament
        error("Tournament #{id} is not found")
        return
      end

      players = @player_repo.find_with_scores_by_tournament_id(tournament_id: id)
      rounds = @round_repo.find_with_scores_by_tournament_id(tournament_id: id)

      @tournament = Tournament.new(tournament.to_h.merge(players: players, rounds: rounds))
    end
  end
end
