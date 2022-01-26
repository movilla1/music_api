# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Artists", type: :request do
  describe "GET /index" do
    before do
      create(:artist, name: "Bruno Mars")
      create(:artist)
    end

    it "returns Artist list" do
      get "/artists"
      expect(response.body).to include("Bruno Mars")
    end
  end

  describe "GET /show" do
    let(:artist) { create(:artist) }

    it "returns the selected record" do
      get "/artists/#{artist.id}"
      expect(response.body).to include(artist.name)
    end
  end

  describe "PUT /artists" do
    let(:artist) { create(:artist) }

    it "updates the record" do
      put "/artists/#{artist.id}", params: { artist: { name: "Change IT" } }
      expect(artist.reload.name).to eq("Change IT")
    end

    it "Fails to update the record" do
      original_name = artist.name
      put "/artists/#{artist.id}", params: { artist: { name: nil } }
      expect(artist.reload.name).to eq(original_name)
    end
  end

  describe "POST /create" do
    let(:valid_params) do
      {
        artist: {
          name: "Disturbed",
          biography: "Disturbed is an American heavy metal band from Chicago, formed in 1994. " \
                     "The band includes vocalist David Draiman, guitarist/keyboardist Dan Donegan," \
                     " bassist John Moyer and drummer Mike Wengren. Donegan and Wengren have been involved" \
                     " in the band since its inception, with Moyer replacing former bassist Steve \"Fuzz\" Kmak"\
                     " and Draiman replacing original lead vocalist Erich Awalt."
        }
      }
    end
    let(:invalid_params) { {artist: { name: nil, biography: nil } } }

    it "adds a new artist" do
      expect { post("/artists", params: valid_params) }.to change(Artist, :count).by(1)
    end

    it "Fails to add an artist" do
      expect { post("/artists", params: invalid_params) }.not_to change(Artist, :count)
    end
  end

  describe "DELETE /destroy" do
    let!(:artist) { create(:artist) }

    it "destroys the record" do
      expect { delete "/artists/#{artist.id}" }.to change(Artist, :count).by(-1)
    end

    it "Fails to destroy" do
      expect { delete "/artists/fake_id" }.not_to change(Artist, :count)
    end
  end
end
