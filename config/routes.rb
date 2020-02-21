Swagger::Docs::Config.base_api_controller = ActionController::API
include Swagger::Docs::ImpotentMethods

Rails.application.routes.draw do
  resources :messages, only: [:index, :create, :update, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
