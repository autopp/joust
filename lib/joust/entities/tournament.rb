class Tournament < Hanami::Entity
  def ranking
    ranking_values = players.map do |player|
      v = [player.scores.map(&:tp).reduce(&:+)]
      v << player.scores.map(&:vp).reduce(&:+) if total_vp_used
      [v, player]
    end

    ranking_values.sort.map.with_index { |(_, p), i| [i + 1, p] }
  end
end
