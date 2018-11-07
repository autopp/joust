class ScoreRepository < Hanami::Repository
  associations do
    belongs_to :player
    belongs_to :round
  end

  def find_by_round_id(id)
    scores.where(round_id: id).to_a
  end
end
