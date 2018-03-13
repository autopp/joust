module Web::Controllers::Round
  class Create
    include Web::Action

    def initialize(create_round: Interactors::CreateRound.new)
      @create_round = create_round
    end

    def call(params)
    end
  end
end
