Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  root to: "rooms#index"
  resources :rooms, only: %i[show create], param: :title
  resources :messages, only: %i[ create ] do
    member { post :like }
  end
end
