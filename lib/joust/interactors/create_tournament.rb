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
      Validator.new(@params.merge(player_names: @player_names)).validate.success?
    end

    class Validator
      include Hanami::Validations

      validations do
        required(:player_names) { size?(6..Float::INFINITY) | size?(3..4) }
        required(:name) { str? & filled? }
      end
    end
  end
end
