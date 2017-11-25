require_relative '../views_helper.rb'
require_relative '../../../../apps/web/views/tournament/create'

RSpec.describe Web::Views::Tournament::Create, type: :view do
  let(:exposures) { { params: {} } }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/tournament/new.html.erb') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  it_behaves_like 'common view', title: 'New Tournament', back_path: Web.routes.path(:tournaments)

  describe '#form' do
    subject { view.form.to_s }

    it 'generates form to create a tournament' do
      expect(subject).to start_with('<form') & end_with('</form>')
    end

    it 'is included in rendered' do
      expect(rendered).to include(subject)
    end
  end
end
