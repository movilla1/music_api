# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Albums", type: :request do
  describe "GET /index" do
    before do
      create(:album, name: "Bruno Mars")
      create(:album)
    end

    it "returns Album list" do
      get "/albums"
      expect(response.body).to include("Bruno Mars")
    end
  end

  describe "GET /show" do
    let(:album) { create(:album) }

    it "returns the selected record" do
      get "/albums/#{album.id}"
      expect(response.body).to include(album.name)
    end
  end

  describe "PUT /albums" do
    let(:album) { create(:album) }

    it "updates the record" do
      put "/albums/#{album.id}", params: { album: { name: "Change IT" } }
      expect(album.reload.name).to eq("Change IT")
    end

    it "Fails to update the record" do
      original_name = album.name
      put "/albums/#{album.id}", params: { album: { name: nil } }
      expect(album.reload.name).to eq(original_name)
    end
  end

  describe "POST /create" do
    let(:valid_params) do
      {
        album: {
          name: "Out of control",
          year: Time.current - 2.years
        }
      }
    end
    let(:invalid_params) { {album: { name: nil, year: nil } } }

    it "adds a new album" do
      expect { post("/albums", params: valid_params) }.to change(Album, :count).by(1)
    end

    it "Fails to add an album" do
      expect { post("/albums", params: invalid_params) }.not_to change(Album, :count)
    end
  end

  describe "DELETE /destroy" do
    let!(:album) { create(:album) }

    it "destroys the record" do
      expect { delete "/albums/#{album.id}" }.to change(Album, :count).by(-1)
    end

    it "Fails to destroy" do
      expect { delete "/albums/fake_id" }.not_to change(Album, :count)
    end
  end
end
