require 'hanami/interactor'

module Interactors
  class CreateRound
    include Hanami::Interactor

    expose :round

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

      tournament = res.tournament
      if tournament.ongoing_round
        error("'#{tournament.name}' has ongoing round")
        return
      end

      @round = @tournament_repo.add_round(tournament)
      players = tournament.ranking.map { |hash| hash[:player] }.reject(&:droped_round)
      three_players_table_size = (4 - players.size) % 4
      four_players_table_size = (players.size + 3) / 4 - three_players_table_size
      table_number = 1
      players.take(four_players_table_size * 4).each_slice(4) do |players|
        players.each do |player|
          @score_repo.create(
            player_id: player.id, round_id: @round.id, table_number: table_number, player_count: 4
          )
        end
        table_number += 1
      end
      players.drop(four_players_table_size * 4).each_slice(3) do |players|
        players.each do |player|
          @score_repo.create(
            player_id: player.id, round_id: @round.id, table_number: table_number, player_count: 3
          )
        end
        table_number += 1
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
