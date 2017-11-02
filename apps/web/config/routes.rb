# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
get '/tournament/:id', to: 'tournament#show', as: :tournament
get '/tournament/new', to: 'tournament#new', as: :new_tournament
get '/tournaments', to: 'tournament#index', as: :tournaments

root to: 'tournament#index'
