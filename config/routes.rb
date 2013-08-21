SplitAmongUs::Application.routes.draw do
  devise_for :users, :controllers => { :invitations => 'users/invitations' }
  resources :users, only: [] do
    resources :bills, only: [:index]
  end
  match 'users/:id' => 'users#show', as: :users
  resources :dashboard, only: [:index]

  resources :lists, except: [:edit] do
    resources :bills, only: [:show, :create, :edit, :update, :destroy]
    resources :settlements, only: [:new, :create]
  end

  resources :groups, only: [:destroy]

  authenticated :user do
    root :to => "dashboard#index"
  end

  root :to => "home#index"
end
