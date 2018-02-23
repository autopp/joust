module Web::Controllers::Player
  class Update
    include Web::Action

    expose :player

    def initialize(drop_player: Interactors::DropPlayer.new)
      @interactor = drop_player
    end

    def call(params)
      result = @interactor.call(params)
      if result.success?
        @player = result.player
      else
        @errors = result.errors
        self.status = 400
      end
    end
  end
end
