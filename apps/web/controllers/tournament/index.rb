module Web::Controllers::Tournament
  class Index
    include Web::Action

    expose :tournaments

    def initialize(repo: TournamentRepository.new)
      @repo = repo
    end

    def call(_params)
      @tournaments = @repo.all
    end
  end
end
