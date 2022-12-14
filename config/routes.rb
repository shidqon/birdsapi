Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get '/birds', to: 'birds#index'
  get '/birds/:id', to: 'birds#show'
  post '/birds', to: 'birds#create'
  patch '/birds/:id', to: 'birds#update'
  delete '/birds/:id', to: 'birds#delete'
end
