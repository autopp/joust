require 'hanami/interactor'

module Interactors
  class CreateTournament
    include Hanami::Interactor

    expose :tournament

    def initialize(repo: TournamentRepository.new)
      @repo = repo
    end

    def call(params)
      args = params[:tournament].to_h.merge!(players: @player_names.map { |n| { name: n } })
      @tournament = @repo.create_with_players(args)
    end

    private

    def valid?(params)
      input = params[:tournament]
      @player_names = input[:players].to_s.each_line.map(&:chomp).reject(&:empty?)
      result = Validator.new(input.merge(player_names: @player_names)).validate
      if result.success?
        true
      else
        error(result.messages)
        false
      end
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
