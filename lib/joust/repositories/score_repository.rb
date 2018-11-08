class ScoreRepository < Hanami::Repository
  associations do
    belongs_to :player
    belongs_to :round
  end

  def find_with_player_by_round_id(id)
    aggregate(:player).where(round_id: id).map_to(Score).to_a
  end
end
