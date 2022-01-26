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
    params.require(:album).permit(:name, :year, :album_art)
  end

  def album_object_response(status, payload)
    { status: status, payload: payload }
  end
end
