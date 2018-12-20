Rails.application.routes.draw do


  #custom routes:
  get '/groups/:id/join_group', to: 'groups#join_group'
  

  #standard routes:
  resources :groups
  devise_for :users, :controllers => { registrations: 'registrations' }

  root 'groups#index'




  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
