# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
get '/tournaments', to: 'tournament#index', as: :tournaments
get '/tournaments/new', to: 'tournament#new', as: :new_tournament
get '/tournaments/:id', to: 'tournament#show', as: :tournament

root to: 'tournament#index'
post '/tournament', to: 'tournament#create'
