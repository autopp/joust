class ScoreRepository < Hanami::Repository
  associations do
    belongs_to :player
    belongs_to :round
  end
end
