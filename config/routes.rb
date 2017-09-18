Rails.application.routes.draw do
  root to: 'home#index'

  resources :posts
  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"},
                     controllers: { omniauth_callbacks: "callbacks",
                                    registrations: 'users/registrations',
                                    essions: 'users/sessions' }
end
