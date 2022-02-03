# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "static#root"

  resources :artists do
    member do
      post :bulk_albums
      post :bulk_albums_text
    end
  end

  resources :albums do
    member do
      post :bulk_songs
      post :bulk_songs_text
    end
  end

  resources :songs do
    member do
      post :bulk_artists
      post :bulk_artist_text
    end
  end
end
