# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
get '/tournament/:id', to: 'tournament#show', as: :tournaments
get '/tournament', to: 'tournament#index', as: :tournament

root to: 'tournament#index'
