RSpec.describe Web::Controllers::Round::Show, type: :action do
  let(:action) { described_class.new(tournament_repo: tournament_repo, round_repo: round_repo) }
  let(:params) { { tournament_id: tournament_id.to_s, number: number.to_s } }
  let(:tournament_id) { 1 }
  let(:number) { 2 }

  let(:tournament_repo) { instance_double(TournamentRepository) }
  let(:round_repo) { instance_double(RoundRepository) }
  subject { action.call(params) }

  context 'when parameters are valid' do
    let(:tournament) { Tournament.new(id: tournament_id) }

    before do
      allow(tournament_repo).to receive(:find).with(tournament_id.to_s).and_return(tournament)
    end

    it 'is successful' do
      expect(subject[0]).to eq(200)
    end

    it 'exposes tournament' do
      subject
      expect(action.exposures).to include(tournament: tournament)
    end
  end
end
