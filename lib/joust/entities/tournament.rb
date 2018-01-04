class Tournament < Hanami::Entity
  def ranking
    ranking_values = players.group_by do |player|
      tp, vp, rank_history = player.ranking_value
      value = [tp]
      value << vp if total_vp_used
      value << rank_history if rank_history_used
      value
    end

    rank = 1
    ranking_values.sort_by(&:first).reverse.each_with_object([]) do |(_, players), r|
      players.each { |p| r << { rank: rank, player: p } }
      rank += players.size
    end
  end
end
