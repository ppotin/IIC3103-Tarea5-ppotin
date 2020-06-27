Rails.application.routes.draw do
  get '/search' => 'welcome#search', :as => 'search_page'
  get 'locations/show/:id' => 'locations#show'
  get 'characters/show/:id' => 'characters#show'
  get 'episodes/show/:id' => 'episodes#show'
  get 'welcome/index'
  root 'welcome#index'
end
