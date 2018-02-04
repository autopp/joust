require 'hanami/interactor'

module Interactors
  class DropPlayer
    include Hanami::Interactor

    def initialize(repo: PlayerRepository.new)
      @repo = repo
    end

    def call(_)
    end
  end
end
