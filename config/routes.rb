Rails.application.routes.draw do
  #resources :messages
  get 'messages/', to: 'messages#list'
  post 'messages/', to: 'messages#create'
  put 'messages/:id', to: 'messages#publish'
  delete 'messages/:id', to: 'messages#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
