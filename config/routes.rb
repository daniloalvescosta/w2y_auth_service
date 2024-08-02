Rails.application.routes.draw do
  devise_for :users

  post "register", to: "authentication#register"
  post "login", to: "authentication#login"
end
