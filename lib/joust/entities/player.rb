class Player < Hanami::Entity
  def ranking_value(finished_count)
    scores.take(finished_count).each_with_object([0, 0, [0, 0, 0, 0]]) do |score, value|
      value[0] += score.tp
      value[1] += score.vp
      value[2][score.rank - 1] += 1
    end
  end

  def total_tp(finished_count)
    scores.take(finished_count).map(&:tp).reduce(&:+)
  end

  def total_vp(finished_count)
    scores.take(finished_count).map(&:vp).reduce(&:+)
  end
end
