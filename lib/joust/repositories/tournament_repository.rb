class TournamentRepository < Hanami::Repository
  associations do
    has_many :players
    has_many :rounds
  end

  def create_with_players(params)
    assoc(:players).create(params)
  end

  def add_round(tournament)
    assoc(:rounds, tournament).add(number: tournament.finished_count + 1)
  end
end
