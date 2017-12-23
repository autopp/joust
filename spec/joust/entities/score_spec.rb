RSpec.describe Score, type: :entity do
  let(:score) do
    described_class.new(
      player_count: 3, vp_gained: 30, has_extra_turn: true,
      rank: 1, same_ranks: 2
    )
  end

  describe '#vp' do
    subject { score.vp }

    it { is_expected.to eq(30 * Rational(3, 4)) }
  end

  describe '#tp' do
    subject { score.tp }

    xit { is_expected.to(Rational(6 + 3, 2)) }
  end
end
