Rails.application.routes.draw do
  # Defines the (user) login route.
  post "/login", to: "user#login"

  # Defines the GET user route.
  get "/user/:id", to: "user#show"

  # Defines expense routes.
  get "/expense", to: "expense#index"
  post "/expense", to: "expense#create"
  patch "/expense/:id/approve", to: "expense#approve"
  patch "/expense/:id/reject", to: "expense#reject"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
