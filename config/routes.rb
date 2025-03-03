Rails.application.routes.draw do
  get "/expense", to: "expense#index"
  post "/expense", to: "expense#create"
  patch "/expense/:id/approve", to: "expense#approve"
  patch "/expense/:id/reject", to: "expense#reject"


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
