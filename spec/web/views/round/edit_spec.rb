require_relative '../views_helper.rb'
require_relative '../../../../apps/web/views/round/edit'

RSpec.describe Web::Views::Round::Edit, type: :view do
  let(:exposures) do
    tournament = Tournament.new(id: 1, name: 'My Tournament')
    { round: Round.new(id: 2, tournament_id: 1, number: 2, tournament: tournament) }
  end
  let(:template)  { Hanami::View::Template.new('apps/web/templates/round/edit.html.erb') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  it_behaves_like 'common view', title: 'My Tournament: Round 2',
                                 back_path: Web.routes.path(:tournament, id: 1)
end
