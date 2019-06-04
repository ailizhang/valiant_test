Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # API routes
  namespace :api do
    namespace :v1 do
      defaults format: :json do
        resources :tasks, only: [:create, :update, :show]
      end
    end
  end
end
