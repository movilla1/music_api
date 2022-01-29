# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Songs", type: :request do
  before do
    5.times { |n| create(:song, name: "FakeSong #{n}") }
  end

  describe "GET /index" do
    it "returns http success" do
      get "/songs"
      expect(response.body).to include("FakeSong 3")
    end
  end

  describe "GET /songs/:id" do
    let(:song) { create(:song) }

    it "returns http success" do
      get "/songs/#{song.id}"
      expect(response.body).to include(song.name)
    end
  end

  describe "POST /create" do
    let(:valid_song_params) do
      {
        name: Faker::Ancient.hero,
        genre: "pop",
        duration: 123,
        featured: false,
        track_numb: 5
      }
    end

    it "creates a new record" do
      expect { post "/songs", params: { song: valid_song_params } }.to change(Song, :count).by(1)
    end

    it "fails to create song" do
      invalid_params =  valid_song_params.except(:name)
      expect { post "/songs", params: { song: invalid_params } }.not_to change(Song, :count)
    end
  end

  describe "PUT /update" do
    let(:song) { create(:song) }
    let(:valid_song_update_params) { { song: { name: "NEW SONG NAME" } } }

    it "updates the name" do
      put "/songs/#{song.id}", params: valid_song_update_params
      expect(song.reload.name).to eq("NEW SONG NAME")
    end

    it "fails to update unexisting record" do
      put "/songs/whatever", params: valid_song_update_params
      expect(response.body).to include("FAIL")
    end
  end

  describe "DELETE /songs" do
    let!(:song) { create(:song) }

    it "destroys the song" do
      expect { delete "/songs/#{song.id}" }.to change(Song, :count).by(-1)
    end

    it "fails to destroy a song" do
      expect { delete "/songs/falafel" }.not_to change(Song, :count)
    end
  end
end
