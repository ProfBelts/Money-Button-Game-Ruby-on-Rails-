Rails.application.routes.draw do

  root "game#index"

  post "bet", to: 'game#bet'
  post "start", to: "game#process_game"


  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
