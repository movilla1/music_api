# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "pages#root"
  resources :artists
  resources :albums
  resources :songs
end
