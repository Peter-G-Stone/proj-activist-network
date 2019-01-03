Rails.application.routes.draw do


  #custom routes:
  #
  #
  get '/groups/:id/join_group', to: 'groups#join_group'
  get '/groups/:id/leave_group', to: 'groups#leave_group'

  #omniauth routes:
  get '/auth/facebook/callback' => 'omniauth_sessions#create'

  
  
  #standard routes:
  

  resources :posts, only: [] do
    resources :comments, except: [:index, :show]
  end
  resources :groups do 
    resources :posts, except: [:index, :show]
  end
  devise_for :users, :controllers => { registrations: 'registrations' }


  root 'groups#index'




  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
