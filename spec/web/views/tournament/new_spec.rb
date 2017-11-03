require_relative '../../../../apps/web/views/tournament/new'

RSpec.describe Web::Views::Tournament::New do
  let(:exposures) { {} }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/tournament/new.html.erb') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  it_behaves_like 'common view', title: 'New Tournament', back_path: Web.routes.path(:tournaments)
end
