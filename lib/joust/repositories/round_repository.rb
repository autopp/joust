class RoundRepository < Hanami::Repository
  associations do
    belongs_to :tournament
    has_many :scores
    has_many :players, through: :scores
  end

  def find_with_scores_by_tournament_id(tournament_id)
    aggregate(:tournament, :scores).where(tournament_id: tournament_id).map_to(Round).to_a
  end
end
