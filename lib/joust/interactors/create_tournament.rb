require 'hanami/interactor'

module Interactors
  class CreateTournament
    include Hanami::Interactor

    expose :tournament

    def initialize(repo: TournamentRepository.new)
      @repo = repo
    end

    def call(params)
      input = params[:tournament]
      args = {
        name: input[:name], players: @player_names.map { |n| { name: n } },
        total_vp_used: input[:total_vp_used], rank_history_used: input[:rank_history_used]
      }
      @tournament = @repo.create_with_players(args)
    end

    private

    def valid?(params)
      input = params[:tournament]
      @player_names = input[:players].to_s.each_line.map(&:chomp).reject(&:empty?)
      result = Validator.new(input.merge(players: @player_names)).validate
      if result.success?
        true
      else
        result.messages.each do |k, msg|
          error("#{k}: #{msg}")
        end
        false
      end
    end

    class Validator
      include Hanami::Validations

      validations do
        required(:players) { size?(6..Float::INFINITY) | size?(3..4) }
        required(:name) { str? & filled? }
      end
    end
  end
end
