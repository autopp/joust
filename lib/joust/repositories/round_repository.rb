class RoundRepository < Hanami::Repository
  associations do
    has_many :scores
  end
end
