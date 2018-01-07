class TournamentRepository < Hanami::Repository
  associations do
    has_many :players
    has_many :rounds
  end

  def create_with_players(params)
    assoc(:players).create(params)
  end

  def find_with_rounds(id)
    aggregate(:rounds).where(id: id).as(Tournament).one
  end
end
