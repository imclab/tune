Tune::Application.routes.draw do
  root :to => "artists#index"
  
  #resources :artists do
  #  resources :songs
  #end
  
  match "/new" => "artists#new", :via => :get, :as => :new_artist
  match "/" => "artists#create", :via => :post
  match "/:id" => "artists#show", :via => :get, :as => :artist
  match "/:id/edit" => "artists#edit", :via => :get, :as => :edit_artist
  match "/:id" => "artists#update", :via => :put
  
  match "/:artist_id/new" => "songs#new", :via => :get, :as => :new_song
  match "/:artist_id" => "songs#create", :via => :post
  match "/:artist_id/:id" => "songs#show", :via => :get, :as => :song
  match "/:artist_id/:id/edit" => "songs#edit", :via => :get, :as => :edit_song
  match "/:artist_id/:id" => "songs#update", :via => :put
  match "/:artist_id/:id" => "songs#show"
end