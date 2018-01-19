require_relative '../../../../apps/web/views/tournament/show'

RSpec.describe Web::Views::Tournament::Show, players: 7 do
  let(:exposures) { { tournament: tournament } }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/tournament/show.html.erb') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  let(:tournament) do
    ::Tournament.new(
      id: 1, name: 'My Tournament', finished_count: finished_count,
      rounds: rounds, players: players
    )
  end
  let(:finished_count) { 2 }

  it_behaves_like 'common view', title: 'My Tournament', back_path: Web.routes.path(:tournaments)

  describe '#ranking_table' do
    subject { view.ranking_table }

    it 'contains table tag' do
      expect(subject.to_s).to have_tag('table')
    end
  end

  describe '#round_link' do
    subject { view.round_link }

    context 'when ongoring round exists' do
      let(:finished_count) { 1 }

      it 'contains link to ongoing round page' do
        path = Web.routes.path(:round, tournament_id: 1, number: 2)
        expect(subject.to_s).to have_tag('a', with: { aref: path })
      end
    end

    context 'when ongoring round exists' do
      let(:finished_count) { 2 }

      it 'contains link to ongoing round page' do
        path = Web.routes.path(:rounds, tournament_id: 1)
        expect(subject.to_s).to have_tag('a', with: { aref: path })
      end
    end
  end
end
