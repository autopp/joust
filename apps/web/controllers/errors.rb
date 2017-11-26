module Web::Controllers
  module Errors
    def self.included(action)
      action.class_eval do
        expose :errors
      end
    end
  end
end
