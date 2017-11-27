module Web::Controllers::Tournament
  class Show
    include Web::Action

    expose :tournament

    def initialize(repo: TournamentRepository.new)
      @repo = repo
    end

    def call(params)
      @tournament = @repo.find(params[:id])
    end
  end
end
