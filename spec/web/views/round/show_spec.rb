require_relative '../views_helper.rb'
require_relative '../../../../apps/web/views/round/show'

RSpec.describe Web::Views::Round::Show, type: :view do
  let(:exposures) do
    {
      tournament: Tournament.new(id: 1, name: 'My Tournament'),
      round: Round.new(id: 1, number: 2)
    }
  end

  let(:template)  { Hanami::View::Template.new('apps/web/templates/round/show.html.erb') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  back_path = Web.routes.path(:tournament, id: 1)
  it_behaves_like 'common view', title: 'My Tournament: Round 2', back_path: back_path do
    before { pending }
  end
end
