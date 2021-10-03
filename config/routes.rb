Myrottenpotatoes::Application.routes.draw do

	get '/movies/search_tmdb', :controller => 'movies', :action => 'search_tmdb'
	post '/movies/createfromtmdb', :controller => 'movies', :action => 'create_from_tmdb'

	resources :movies do
		resources :reviews
	end

	root :to => redirect('/movies')

	# fb authentication
	devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

end
