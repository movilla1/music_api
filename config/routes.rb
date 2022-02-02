# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "static#root"
  resources :artists
  resources :albums
  resources :songs
end
