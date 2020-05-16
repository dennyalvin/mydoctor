Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      post '/register', to: 'auth#register'
      post '/login', to: 'auth#login'

      get '/doctors' , to: 'doctor#index'
      get '/schedules', to: 'doctor_schedule#index'

      get '/hospitals', to: 'hospital#index'

      get 'bookings', to: 'booking#index'
      post '/bookings/create', to: 'booking#create'

    end
  end

end
