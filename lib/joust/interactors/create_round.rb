require 'hanami/interactor'

module Interactors
  class CreateRound
    include Hanami::Interactor

    def initialize(
      tournament_repo: TournamentRepository.new, score_repo: ScoreRepository,
      find_tournament: Interactors::FindTournament.new
    )
      @tournament_repo = tournament_repo
      @score_repo = score_repo
      @find_tournament = find_tournament
    end

    def call(params)
      res = @find_tournament.call(id: params[:tournament_id])
      unless res.success?
        error(*res.errors)
        return
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
        required(:tournament_id) { format?(/\A[0-9]+\z/) }
      end
    end
  end
end
