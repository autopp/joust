class Tournament < Hanami::Entity
  def ranking
    ranking_values = players.group_by do |player|
      scores = player.scores.take(finished_count)
      v = [scores.map(&:tp).reduce(&:+)]
      v << scores.map(&:vp).reduce(&:+) if total_vp_used
      if rank_history_used
        v << scores.each_with_object(Array.new(4, 0)) { |s, counts| counts[s.rank - 1] += 1 }
      end
      v
    end

    rank = 1
    ranking_values.sort_by(&:first).reverse.each_with_object([]) do |(_, players), r|
      players.each { |p| r << { rank: rank, player: p } }
      rank += players.size
    end
  end
end
