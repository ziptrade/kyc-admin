Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  resource :session, controller: "clearance/sessions", only: [:create]
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]

  constraints Clearance::Constraints::SignedIn.new do

    resources :rejected_reasons
    resources :users do
      member do
        put 'reset_auth_token'
      end
    end

    delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"

    resources :users, controller: "clearance/users", only: [:create] do
      resource :password,
        controller: "clearance/passwords",
        only: [:create, :edit, :update]
    end

    root to: 'dashboard#index'
  end

  # Disabled Clearence routes
  # get "/sign_up" => "clearance/users#new", as: "sign_up"
  root to: "application#welcome"
end
