module Web::Controllers::Player
  class Update
    include Web::Action

    def initialize(interactor: Interactors::DropPlayer.new)
      @interactor = interactor
    end

    def call(params)
    end
  end
end
