SplitAmongUs::Application.routes.draw do
  devise_for :users, :controllers => { :invitations => 'users/invitations' }
  resources :users, only: [] do
    resources :bills, only: [:index], module: "users"
  end
  match 'users/:id' => 'users#show', as: :users
  match '/dashboard/stats' => 'dashboard#stats' 
  match '/lists/:id/stats' => 'lists#stats'
   match '/bills/stats' => 'users/bills#stats'
  resources :dashboard, only: [:index]

  resources :lists, except: [:edit] do
    resources :bills, except: [:new]
    resources :settlements, only: [:new, :create]
  end

  resources :groups, only: [:destroy]

  authenticated :user do
    root :to => "dashboard#index"
  end

  root :to => "home#index"
end
