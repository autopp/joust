module Web::Controllers::Player
  class Update
    include Web::Action

    expose :player

    def initialize(interactor: Interactors::DropPlayer.new)
      @interactor = interactor
    end

    def call(params)
      result = @interactor.call(params)
      @player = result.player
    end
  end
end
