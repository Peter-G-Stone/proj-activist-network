Rails.application.routes.draw do


  get 'comment/new'
  get 'comment/create'
  get 'comment/edit'
  get 'comment/update'
  get 'comment/destroy'
  #custom routes:
  #
  #
  get '/groups/:id/join_group', to: 'groups#join_group'
  get '/groups/:id/leave_group', to: 'groups#leave_group'
  
  
  #standard routes:
  #
  #
  resources :comments

  resources :posts do
    resources :comments, except: [:index, :show]
  end
  resources :groups do 
    resources :posts, except: [:index, :show]
  end
  devise_for :users, :controllers => { registrations: 'registrations' }


  root 'groups#index'




  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
