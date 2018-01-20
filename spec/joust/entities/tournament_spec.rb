RSpec.describe Tournament, players: 7 do
  let(:tournament) do
    described_class.new(
      finished_count: finished_count, players: players, rounds: rounds,
      total_vp_used: total_vp_used, rank_history_used: rank_history_used
    )
  end

  describe '#ranking' do
    subject { tournament.ranking }

    context 'when finished round is one' do
      let(:finished_count) { 1 }
      let(:total_vp_used) { true }
      let(:rank_history_used) { true }

      it 'returns ranking from scores of round 1' do
        expect(subject).to eq(
          [
            { rank: 1, player: player1 },
            { rank: 2, player: player5 },
            { rank: 3, player: player2 },
            { rank: 4, player: player6 },
            { rank: 5, player: player3 },
            { rank: 6, player: player7 },
            { rank: 7, player: player4 }
          ]
        )
      end
    end

    context 'when finished round is two' do
      let(:finished_count) { 2 }

      context 'when total vp is used' do
        let(:total_vp_used) { true }

        context 'when rank history is used' do
          let(:rank_history_used) { true }

          it 'returns ranking from scores of round 2' do
            expect(subject).to eq(
              [
                { rank: 1, player: player1 },
                { rank: 2, player: player5 },
                { rank: 3, player: player4 },
                { rank: 4, player: player2 },
                { rank: 5, player: player3 },
                { rank: 6, player: player7 },
                { rank: 7, player: player6 }
              ]
            )
          end
        end

        context 'when rank history is not used' do
          let(:rank_history_used) { false }

          it 'returns ranking from scores of round 2' do
            expect(subject).to eq(
              [
                { rank: 1, player: player1 },
                { rank: 2, player: player5 },
                { rank: 3, player: player2 },
                { rank: 3, player: player4 },
                { rank: 5, player: player3 },
                { rank: 6, player: player6 },
                { rank: 6, player: player7 }
              ]
            )
          end
        end
      end

      context 'when total vp is not used' do
        let(:total_vp_used) { false }

        context 'when rank history is used' do
          let(:rank_history_used) { true }

          it 'returns ranking from scores of round 2' do
            expect(subject).to eq(
              [
                { rank: 1, player: player1 },
                { rank: 2, player: player5 },
                { rank: 3, player: player4 },
                { rank: 4, player: player2 },
                { rank: 5, player: player3 },
                { rank: 5, player: player7 },
                { rank: 7, player: player6 }
              ]
            )
          end
        end

        context 'when rank history is not used' do
          let(:rank_history_used) { false }

          it 'returns ranking from scores of round 2' do
            expect(subject).to eq(
              [
                { rank: 1, player: player1 },
                { rank: 2, player: player5 },
                { rank: 3, player: player2 },
                { rank: 3, player: player4 },
                { rank: 5, player: player3 },
                { rank: 5, player: player6 },
                { rank: 5, player: player7 }
              ]
            )
          end
        end
      end
    end
  end

  describe '#ongoing_round' do
    subject { tournament.ongoing_round }

    let(:total_vp_used) { true }
    let(:rank_history_used) { true }

    context 'when #finished_count is less than count of rounds' do
      let(:finished_count) { 1 }

      it 'returns round 2' do
        expect(subject).to eq(round2)
      end
    end

    context 'when #finished_count equals count of rounds' do
      let(:finished_count) { 2 }

      it { is_expected.to be_nil }
    end
  end
end
