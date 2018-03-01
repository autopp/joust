RSpec.describe Web::Controllers::Player::Update, type: :action do
  let(:action) { described_class.new(drop_player: drop_player, find_tournament: find_tournament) }
  let(:params) { { tournament_id: '1', id: '2' } }
  let(:drop_player) { instance_double(Interactors::DropPlayer) }
  let(:find_tournament) { instance_double(Interactors::FindTournament) }

  subject { action.call(params) }

  context 'when interactor succeeds' do
    let(:player) { Player.new(id: 2, tournament_id: 1, name: 'player1') }
    let(:tournament) { Tournament.new(id: 1, name: 'My Tournament') }

    before do
      drop_result = double('DropPlayer result')
      allow(drop_result).to receive(:success?).and_return(true)
      allow(drop_result).to receive(:errors).and_return([])
      allow(drop_result).to receive(:player).and_return(player)

      expected_args = satisfying { |o| o.to_h == params }
      allow(drop_player).to receive(:call).with(expected_args).and_return(drop_result)

      find_result = double('FindPlayer result')
      allow(find_result).to receive(:tournament).and_return(tournament)
      allow(find_tournament).to receive(:call).with(id: 1).and_return(find_result)
    end

    it 'is successful' do
      expect(subject[0]).to eq 200
    end

    it 'exposes no error' do
      subject
      expect(action.exposures).to include(errors: nil)
    end

    it 'exposes the player' do
      subject
      expect(action.exposures).to include(player: player)
    end

    it 'exposes the tournament' do
      subject
      expect(action.exposures).to include(tournament: tournament)
    end
  end

  context 'when interactor fails' do
    let(:errors) { %w[error] }

    before do
      result = double('interactor result')
      allow(result).to receive(:success?).and_return(false)
      allow(result).to receive(:errors).and_return(errors)

      expected_args = satisfying { |o| o.to_h == params }
      allow(drop_player).to receive(:call).with(expected_args).and_return(result)
    end

    it 'is failure' do
      expect(subject[0]).to eq 400
    end

    it "exposes interactor's error" do
      subject
      expect(action.exposures).to include(errors: errors)
    end
  end
end
