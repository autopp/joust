require 'hanami/interactor'

module Interactors
  class CreateTournament
    include Hanami::Interactor

    expose :tournament

    def initialize(params, repo: TournamentRepository.new)
      @params = params
      @player_names = params[:players].to_s.each_line.map(&:chomp).reject(&:empty?)
      @repo = repo
    end

    def call
      args = @params.to_h.merge!(player_names: @player_names)
      @tournament = @repo.create_with_players(args)
    end

    private

    def valid?
      ![0, 1, 2, 5].member?(@player_names.size)
    end
  end
end
