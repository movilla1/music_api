# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BulkOperations do
  let(:songs) { create_list(:song, 3) }
  let(:artists) { create_list(:artist, 3) }
  let(:artist) { create(:artist) }

  it "Adds AlbumSong records" do
    song_data = [['add', songs[0].id], ['add', songs[1].id], ['add', songs[2].id]]
    album = create(:album)
    expect do
      described_class.process_array(AlbumSong, "song_id", song_data, "album_id", album.id)
    end.to change(AlbumSong, :count).by(3)
  end

  it "Adds AlbumArtist records" do
    artist_data = [['add', artists[0].id], ['add', artists[1].id], ['add', artists[2].id]]
    album = create(:album)
    expect do
      described_class.process_array(AlbumArtist, "artist_id", artist_data, "album_id", album.id)
    end.to change(AlbumArtist, :count).by(3)
  end

  it "Adds ArtistSong records" do
    song_data = [['add', songs[0].id], ['add', songs[1].id], ['add', songs[2].id]]
    expect do
      described_class.process_array(ArtistSong, "song_id", song_data, "artist_id", artist.id)
    end.to change(ArtistSong, :count).by(3)
  end

  it "removes records" do
    song_data = [['add', songs[0].id], ['remove', songs[1].id], ['remove', songs[2].id]]
    ArtistSong.create(artist: artist, song: songs[1])
    ArtistSong.create(artist: artist, song: songs[2])
    expect do
      described_class.process_array(ArtistSong, "song_id", song_data, "artist_id", artist.id)
    end.to change(ArtistSong, :count).by(-1) # Adds 1, removes 2, total = -1
  end
end
