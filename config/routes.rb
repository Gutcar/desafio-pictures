Rails.application.routes.draw do
  resources :pictures do 
    resources :comments, only: [:create]
    member do
      get 'show_and_new_comment', to: 'pictures#show_and_new_comment', as: 'show_and_new_comment'
    end
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pictures#index"
end
