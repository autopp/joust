class TournamentRepository < Hanami::Repository
  associations do
    has_many :players
    has_many :rounds
  end

  def create_with_players(params)
    assoc(:players).create(params)
  end

  def find_with_attrs(id)
  end
end
