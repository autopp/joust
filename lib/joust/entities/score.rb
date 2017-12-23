class Score < Hanami::Entity
  def vp
    Rational(vp_gained * player_count, 4)
  end
end
