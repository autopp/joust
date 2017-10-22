require_relative '../views_helper.rb'
require_relative '../../../../apps/web/views/tournament/index'

RSpec.describe Web::Views::Tournament::Index do
  let(:exposures) { Hash[foo: 'bar'] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/tournament/index.html.erb') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  it_behaves_like 'common view', title: 'List of tournaments', back_path: Web.routes.path(:root)
end
