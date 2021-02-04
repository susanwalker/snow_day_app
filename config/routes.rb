Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/', to: 'locations#index'

  get '/locations/new', to: 'locations#new'
  post '/locations', to: 'locations#create'

  get '/locations/:id/edit_report', to: 'locations#edit_report'
  put '/locations/:id/update_report', to: 'locations#update_report'
end
