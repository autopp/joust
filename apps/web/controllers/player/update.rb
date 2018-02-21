module Web::Controllers::Player
  class Update
    include Web::Action

    expose :player

    def initialize(interactor: Interactors::DropPlayer.new)
      @interactor = interactor
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
