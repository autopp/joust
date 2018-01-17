# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
get '/tournaments', to: 'tournament#index', as: :tournaments
get '/tournaments/new', to: 'tournament#new', as: :new_tournament
post '/tournaments', to: 'tournament#create', as: :tournaments
get '/tournaments/:id', to: 'tournament#show', as: :tournament

get '/tournaments/:tournament_id/rounds/:number', to: 'round#show', as: :round
post '/tournament/:tournament_id/round', to: 'round#create', as: :rounds

root to: 'tournament#index'
