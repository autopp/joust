class TournamentRepository < Hanami::Repository
  associations do
    has_many :players
  end
end
