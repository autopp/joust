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
        ranking_header
      end
    end

    def ranking_header
      html.thead do
        tr do
          td 'Rank', rowspan: '2'
          td 'Name', rowspan: '2', colspan: '2'
          1.upto(tournament.finished_count) do |i|
            td colspan: '2' do
              link = Web.routes.path(:round, tournament_id: tournament.id, number: i)
              link_to("Round #{i}", link, id: i)
            end
          end
          td 'Total', colspan: '2'
        end
      end
    end
  end
end
