Rails.application.routes.draw do
  
  root 'groups#index'


  #custom routes:
  #
  #
  get '/groups/:id/join_group', to: 'groups#join_group'
  get '/groups/:id/leave_group', to: 'groups#leave_group'
  get '/groups/recently_active', to: 'groups#recently_active'


  

  #omniauth routes:
  get '/auth/facebook/callback' => 'sessions#create'

  
  
  #standard routes:
  

  resources :posts, only: [] do
    resources :comments, except: [:index, :show]
  end
  resources :groups do 
    resources :posts, except: [:index]
  end

  
  
  
  devise_for :users, :controllers => { registrations: 'registrations', omniauth_callbacks: 'callbacks' }
  
  resources :profiles, only: [:show]







  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
