# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
get '/tournaments', to: 'tournament#index', as: :tournaments
get '/tournaments/new', to: 'tournament#new', as: :new_tournament
post '/tournaments', to: 'tournament#create', as: :tournaments
get '/tournaments/:id', to: 'tournament#show', as: :tournament

post '/tournament/:tournament_id/rounds', to: 'round#create', as: :rounds
get '/tournaments/:tournament_id/rounds/:number', to: 'round#show', as: :round

patch '/tournaments/:tournament_id/players/:id', to: 'player#update', as: :player

root to: 'tournament#index'
