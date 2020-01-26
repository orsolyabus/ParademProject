Rails.application.routes.draw do
  get "/contacts/search", to: "contacts#search", as: :contacts_search
  resources :contacts
  resources :users, only: [:new, :create, :show, :edit, :update, :destroy]
  resource :sessions, only: [:new, :create, :destroy]
  resources :events do
    resources :rsvps, only: [:new, :create, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
