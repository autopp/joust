module Web::Views::Tournament
  class Show
    include Web::View

    def title
      tournament.name
    end

    def back_path
      Web.routes.path(:tournaments)
    end

    def ranking_table
      html.table(class: 'table table-bordered') do
        ranking_header + ranking_body
      end
    end

    def ranking_header # rubocop:disable Metrics/AbcSize
      html.thead do
        tr do
          td 'Rank', rowspan: '2'
          td 'Name', rowspan: '2', colspan: '2'
          1.upto(tournament.finished_count) do |i|
            td(colspan: '2') do
              link = Web.routes.path(:round, tournament_id: tournament.id, number: i)
              link_to("Round #{i}", link, id: i)
            end
          end
          td 'Total', colspan: '2'
        end
        tr do
          tournament.finished_count.times do
            td 'TP'
            td 'VP'
          end
          td 'TP'
          td 'VP'
        end
      end
    end

    def ranking_body # rubocop:disable Metrics/AbcSize
      html.tbody do
        tournament.ranking.each do |rank:, player:|
          tr class: 'ranking-row' do
            td rank, class: 'ranking-player-rank'
            td player.name, class: 'ranking-player-name'
            td '' # TODO: player status
            player.scores.each do |score|
              td score.tp
              td score.vp
            end
            (tournament.finished_count - player.scores.size).times do
              td ''
              td ''
            end
            td player.total_tp(tournament.finished_count)
            td player.total_vp(tournament.finished_count)
          end
        end
      end
    end

    def round_link
      ongoing_round = tournament.ongoing_round

      if ongoing_round
        link_to(
          'Current round',
          Web.routes.path(
            :edit_round, tournament_id: tournament.id, number: ongoing_round.number
          )
        )
      else
        form_for :round, Web.routes.path(:rounds, tournament_id: tournament.id) do
          submit 'Start new round', class: 'btn btn-primary'
        end
      end
    end
  end
end
