class Score < Hanami::Entity
  SCORE_TABLE = [6, 3, 1, 0].freeze

  def vp
    Rational(vp_gained * player_count, 4)
  end

  def tp
    Rational(SCORE_TABLE[rank - 1, same_ranks].reduce(&:+), same_ranks)
  end
end
