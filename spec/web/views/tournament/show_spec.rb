require_relative '../../../../apps/web/views/tournament/show'

RSpec.describe Web::Views::Tournament::Show, players: 7 do
  let(:exposures) { { tournament: tournament } }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/tournament/show.html.erb') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  let(:tournament) do
    ::Tournament.new(
      id: 1, name: 'My Tournament', finished_count: 2,
      rounds: rounds, players: players
    )
  end

  it_behaves_like 'common view', title: 'My Tournament', back_path: Web.routes.path(:tournaments)
end
