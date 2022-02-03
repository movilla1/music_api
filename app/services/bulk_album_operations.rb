# frozen_string_literal: true

# This class will handle bulk operations over a model association
# Specifically AlbumSongs
class BulkAlbumOperations
  ARTIST_COL = 5
  FEATURED_COL = 4
  GENRE_COL = 3
  DURATION_COL = 2
  TRACK_COL = 1
  NAME_COL = 0

  def self.process_songs(album_id, songs_data)
    # format required for the songs data:
    # [ [name:string, track_num:int, duration:int, genre:string, featured:bool, artist_name:string], [...] ]
    songs_data.each do |row|
      artist = Artist.first_or_create(name: row[ARTIST_COLUMN])
      album = Album.find(album_id)
      song = Song.joins(:artists).where(name: row[NAME_COL], artists: [artist_id: artist.id]).first
      if song.present?
        # the song already exist, add it to the album and update details
        song.update(song_row_to_hash(row))
        AlbumSong.create(album: album, song: song)
      else
        # new song and add to album
        new_song = Song.create(song_row_to_hash(row))
        ArtistSong.create(artist: artist, song: new_song)
        AlbumSong.create(album: album, song: new_song)
      end
    end
  end

  def self._song_row_to_hash(row)
    {
      name: row[NAME_COL],
      track_numb: row[TRACK_COL],
      duration: row[DURATION_COL],
      genre: row[GENRE_COL],
      featured: ["1", "t", "true"].include?(row[FEATURED_COL].to_s.downcase)
    }
  end
end
