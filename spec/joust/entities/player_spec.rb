RSpec.describe Player, type: :entity, players: 7 do
  let(:player) { player1 }

  describe '#ranking_value' do
    subject { player.ranking_value }

    it 'returns tuple of tp, vp and rank history' do
      expect(subject).to eq([12 / 1r, 70 / 1r, [2, 0, 0, 0]])
    end
  end
end
