RSpec.describe Player, type: :entity, players: 7 do
  let(:player) { player1 }

  describe '#ranking_value' do
    subject { player.ranking_value(2) }

    it 'returns tuple of tp, vp and rank history' do
      expect(subject).to eq([12 / 1r, 70 / 1r, [2, 0, 0, 0]])
    end
  end

  describe '#total_tp' do
    subject { player.total_tp(2) }

    it 'returns sum of tp' do
      expect(subject).to eq(12 / 1r)
    end
  end

  describe '#total_vp' do
    subject { player.total_vp(2) }

    it 'returns sum of vp' do
      expect(subject).to eq(70 / 1r)
    end
  end
end
