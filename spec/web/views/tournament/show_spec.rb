require_relative '../../../../apps/web/views/tournament/show'

RSpec.describe Web::Views::Tournament::Show do
  let(:exposures) { Hash[tournament: Tournament.new(id: 1, name: 'My Tournament')] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/tournament/show.html.erb') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  it_behaves_like 'common view', title: 'My Tournament', back_path: Web.routes.path(:root)
end
