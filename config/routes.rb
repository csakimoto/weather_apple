Rails.application.routes.draw do

  # Defines the root path route ("/")
  root 'weather#index'


  # routes for weather controller
  resources :weather, only: [:index] do
    # Route to get the temperature based on forecast flag
    post :temperature, on: :collection

    # Route to clear the error message
    get :remove_error, on: :member
  end
end
