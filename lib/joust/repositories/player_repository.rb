class PlayerRepository < Hanami::Repository
  associations do
    belongs_to :tournament
    has_many :scores
  end

  def find_with_scores_by_tournament_id(tournament_id)
    aggregate(:tournament, :scores).where(tournament_id: tournament_id).map_to(Player).to_a
  end
end
