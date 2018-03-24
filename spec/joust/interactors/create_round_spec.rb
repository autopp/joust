describe Interactors::CreateRound do
  let(:interactor) do
    described_class.new(
      tournament_repo: tournament_repo, score_repo: score_repo, find_tournament: find_tournament
    )
  end

  let(:tournament_repo) { instance_double(TournamentRepository) }
  let(:find_tournament) { instance_double(Interactors::FindTournament) }
  let(:score_repo) { instance_double(ScoreRepository) }

  subject { interactor.call(params) }

  shared_examples 'failure case' do
    it 'fails' do
      expect(subject).not_to be_a_success
      expect(subject.errors).not_to be_empty
    end
  end

  context 'when params are valid' do
    let(:tournament_id) { '1' }
    let(:params) { { tournament_id: tournament_id } }
    let(:find_result) { double('FindTournament result') }

    before do
      allow(find_tournament).to receive(:call).with(id: tournament_id).and_return(find_result)
    end

    context 'when the tournament dose not exist' do
      before do
        allow(find_result).to receive(:success?).and_return(false)
        allow(find_result).to receive(:errors).and_return(['error of FindTournament'])
      end

      it_behaves_like 'failure case'
    end

    context 'when the tournament exists' do
      let(:tournament) do
        double(
          'tournament',
          id: tournament_id.to_i, name: 'MyTournament', total_vp_used: true,
          players: [player1]
        )
      end

      let(:player1) do
        score = Score.new(
          id: 1, player_id: 1, round_id: 1,
          table_number: 1, player_count: 4, vp_gained: 30, rank: 1, same_ranks: 1
        )
        Player.new(id: 1, tournament_id: tournament_id.to_i, name: 'player1', scores: [score])
      end

      let(:player2) do
        score = Score.new(
          id: 1, player_id: 2, round_id: 1,
          table_number: 1, player_count: 4, vp_gained: 24, rank: 2, same_ranks: 1
        )
        Player.new(id: 2, tournament_id: tournament_id.to_i, name: 'player2', scores: [score])
      end

      let(:player3) do
        score = Score.new(
          id: 1, player_id: 3, round_id: 1,
          table_number: 1, player_count: 4, vp_gained: 12, rank: 3, same_ranks: 1
        )
        Player.new(id: 3, tournament_id: tournament_id.to_i, name: 'player3', scores: [score])
      end

      let(:player4) do
        score = Score.new(
          id: 1, player_id: 4, round_id: 1,
          table_number: 1, player_count: 4, vp_gained: 6, rank: 4, same_ranks: 1
        )
        Player.new(id: 4, tournament_id: tournament_id.to_i, name: 'player4', scores: [score])
      end

      let(:player5) do
        score = Score.new(
          id: 1, player_id: 5, round_id: 1,
          table_number: 2, player_count: 4, vp_gained: 24, rank: 1, same_ranks: 1
        )
        Player.new(id: 5, tournament_id: tournament_id.to_i, name: 'player5', scores: [score])
      end

      let(:player6) do
        score = Score.new(
          id: 1, player_id: 6, round_id: 1,
          table_number: 2, player_count: 4, vp_gained: 12, rank: 2, same_ranks: 1, droped_round: 1
        )
        Player.new(id: 6, tournament_id: tournament_id.to_i, name: 'player6', scores: [score])
      end

      let(:player7) do
        score = Score.new(
          id: 1, player_id: 7, round_id: 1,
          table_number: 2, player_count: 4, vp_gained: 6, rank: 3, same_ranks: 1
        )
        Player.new(id: 7, tournament_id: tournament_id.to_i, name: 'player7', scores: [score])
      end

      let(:player8) do
        score = Score.new(
          id: 1, player_id: 8, round_id: 1,
          table_number: 2, player_count: 4, vp_gained: 0, rank: 4, same_ranks: 1
        )
        Player.new(id: 8, tournament_id: tournament_id.to_i, name: 'player8', scores: [score])
      end

      before do
        allow(find_result).to receive(:success?).and_return(true)
        allow(find_result).to receive(:tournament).and_return(tournament)
        allow(tournament).to receive(:ongoing_round).and_return(ongoing_round)
      end

      context 'when the tournament has ongoing round' do
        let(:ongoing_round) { instance_double(Round) }

        it_behaves_like 'failure case'
      end

      context 'when the tournament dose not have ongoing round' do
        let(:ongoing_round) { nil }
        let(:round) { Round.new(id: 2, tournament_id: tournament_id.to_i, number: 2) }

        before do
          # it creates a new round
          expect(tournament_repo).to receive(:add_round).with(tournament).and_return(round)
        end

        before do
          expect(score_repo).to receive(:create).with(
            player_id: 1, round_id: 2, table_number: 1, player_count: 4
          )
          expect(score_repo).to receive(:create).with(
            player_id: 2, round_id: 2, table_number: 1, player_count: 4
          )
          expect(score_repo).to receive(:create).with(
            player_id: 3, round_id: 2, table_number: 1, player_count: 4
          )
          expect(score_repo).to receive(:create).with(
            player_id: 4, round_id: 2, table_number: 2, player_count: 3
          )
          expect(score_repo).to receive(:create).with(
            player_id: 5, round_id: 2, table_number: 1, player_count: 4
          )
          expect(score_repo).to receive(:create).with(
            player_id: 7, round_id: 2, table_number: 2, player_count: 3
          )
          expect(score_repo).to receive(:create).with(
            player_id: 8, round_id: 2, table_number: 2, player_count: 3
          )
        end

        it 'succeeds' do
          expect(subject).to be_a_success
        end

        it 'exposes the created tournament' do
          expect(subject.round).to eq(round)
        end
      end
    end
  end

  context 'when params are invalid' do
    let(:params) { {} }

    it_behaves_like 'failure case'
  end
end
