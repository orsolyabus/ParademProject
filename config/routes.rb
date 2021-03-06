Rails.application.routes.draw do
  get "/contacts/search", to: "contacts#search", as: :contacts_search
  get "/contacts/quick_search", to: "contacts#quick_search", as: :quick_search
  resources :contacts
  resources :users, only: [:new, :create, :show, :edit, :update, :destroy]
  resource :sessions, only: [:new, :create, :destroy]
  resources :events do
    get "/rsvps/search", to: "rsvps#search_contacts", as: :rsvp_search
    resources :rsvps, only: [:new, :create, :destroy]
  end
 get "/", to: "sessions#new"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
