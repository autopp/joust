class PlayerRepository < Hanami::Repository
  associations do
    belongs_to :tournament
    has_many :scores
  end
end
