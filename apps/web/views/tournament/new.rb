module Web::Views::Tournament
  class New
    include Web::View

    def title
      'New Tournament'
    end

    def back_path
      Web.routes.path(:tournaments)
    end

    def form
      form_for :tournament, '/tournaments', class: 'center-block' do
        div class: 'row' do
          div class: "col-md-4 col-md-offset-4 center" do
            text_area :players, '', rows: 25, cols: 20, placeholder: "input names per line"
          end
        end

        div class: 'row' do
          div class: "col-md-4 col-md-offset-4 center" do
            check_box :total_vp_used, checked_value: true, unchecked_value: 'false'
            label :total_vp_used
          end
        end

        div class: 'row' do
          div class: "col-md-4 col-md-offset-4 center" do
            check_box :rank_history_used, checked_value: true, unchecked_value: 'false'
            label :rank_history_used
          end
        end

        div class: 'row' do
          div class: "col-md-4 col-md-offset-4 center" do
            submit 'Create', class: 'btn btn-primary'
          end
        end
      end
    end
  end
end
