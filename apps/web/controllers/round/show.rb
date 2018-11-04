module Web::Controllers::Round
  class Show
    include Web::Action

    expose :tournament

    def initialize(tournament_repo: TournamentRepository.new, round_repo: RoundRepository.new)
      @tournament_repo = tournament_repo
      @round_repo = round_repo
    end

    def call(params)
      @tournament = @tournament_repo.find(params[:tournament_id])
    end
  end
end
