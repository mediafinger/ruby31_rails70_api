# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  resources :clients, only: %i(create show)

  mount Rswag::Api::Engine => "/open_api_docs"
  mount Rswag::Ui::Engine => "/open_api_docs"

  root to: proc { [200, {}, [""]] }

  # catch all unknown routes to NOT throw a FATAL ActionController::RoutingError
  match "*path", to: "application#error_404", via: :all,
    constraints: ->(request) { !request.path_parameters[:path].start_with?("rails/") }
end
