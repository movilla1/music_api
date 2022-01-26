# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "pages#root"
  resources :artists
  resources :albums
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
