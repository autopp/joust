module Web::Controllers::Round
  class Show
    include Web::Action

    def initialize(tournament_repo: TournamentRepository.new, round_repo: RoundRepository.new)
      @tournament_repo = tournament_repo
      @round_repo = round_repo
    end

    def call(params)
    end
  end
end
