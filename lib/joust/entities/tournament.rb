class Tournament < Hanami::Entity
  def ranking
    ranking_values = players.group_by do |player|
      scores = player.scores.take(finished_count)
      v = [scores.map(&:tp).reduce(&:+)]
      v << scores.map(&:vp).reduce(&:+) if total_vp_used
      v
    end

    rank = 1
    ranking_values.sort_by(&:first).reverse.each_with_object([]) do |(_, players), r|
      players.each do |p|
        r << { rank: rank, player: p }
      end
      rank += players.size
    end
  end
end
