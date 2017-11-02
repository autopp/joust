# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
get '/tournaments', to: 'tournament#index', as: :tournaments
get '/tournaments/:id', to: 'tournament#show', as: :tournament
get '/tournaments/new', to: 'tournament#new', as: :new_tournament

root to: 'tournament#index'
