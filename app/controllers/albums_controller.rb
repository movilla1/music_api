# frozen_string_literal: true

class AlbumsController < ApplicationController
  before_action :set_album, except: %i[create index]

  ALBUM_PAGE_SIZE = 12

  def index
    albums = Album.all.limit(ALBUM_PAGE_SIZE).offset(params[:page].to_i * ALBUM_PAGE_SIZE)
    render json: album_object_response("OK", albums)
  end

  def show
    render json: album_object_response("OK", @album)
  end

  def create
    album = Album.new(album_params)
    if album.save
      render json: album_object_response("OK", album)
    else
      render json: album_object_response("FAIL", message: "Failed to store a new album")
    end
  end

  def update
    if @album&.update(album_params)
      render json: album_object_response("OK", @album.reload)
    else
      render json: album_object_response("FAIL", message: "Failed to update an album")
    end
  end

  # POST /albums/:album_id/bulk_songs
  # This function takes a posted array with the following format:
  # [ [op, song_id] ]
  # where op can be 'add' or 'remove'
  def bulk_songs
    if BulkOperations::process_array(AlbumSong, "album_id", params[:songs], "song_id", params[:album_id])
      render json: album_object_response("OK", "Songs added to album #{params[:album_id]}")
    else
      render json: album_object_response("FAIL", "Failed to add songs to album #{params[:album_id]}")
    end
  end

  # POST /albums/:album_id/bulk_songs_text
  # Params:
  # @album_id: Album being updated
  # @songs_data: Array with the following format:
  #    [ [name:string, track_num:int, duration:int, genre:string, featured:bool], [...] ]
  def bulk_songs_text
    album_id = params[:album_id]
    if BulkAlbumOperation::process_songs(album_id, params[:songs_data])
      render json: album_object_response("OK", "Songs by text added to album #{album_id}")
    else
      render json: album_object_response("FAIL", "Failed to add songs by text to album #{params[:album_id]}")
    end
  end

  def destroy
    if @album&.destroy
      render json: album_object_response("OK", message: "Album Destroyed")
    else
      render json: album_object_response("FAIL", message: "Failed to destroy the album")
    end
  end

  private

  def set_album
    @album = Album.find_by(id: params[:id])
  end

  def album_params
    params.require(:album).permit(
      :name, :year, :album_art,
      songs: [:duration, :genre, :featured,:id, :name, :track_numb]
    )
  end

  def album_object_response(status, payload)
    { status: status, payload: payload }
  end
end
