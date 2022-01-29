# frozen_string_literal: true

class ArtistsController < ApplicationController
  before_action :set_artist, except: %i[index create]

  ARTIST_PAGE_SIZE = 10

  def index
    artists = Artist.all.limit(ARTIST_PAGE_SIZE).offset(params[:page].to_i * ARTIST_PAGE_SIZE)
    render json: return_object("OK", artists)
  end

  def show
    render json: return_object("OK", @artist)
  end

  def update
    if @artist&.update(artist_params)
      render json: return_object("OK", @artist.reload)
    else
      render return_object("FAIL", "Failed to update Artist")
    end
  end

  def create
    @artist = Artist.new(artist_params)
    if @artist.save
      render json: return_object("OK", @artist.reload)
    else
      render json: return_object("FAIL", "Could not create a new Artist")
    end
  end

  def destroy
    if @artist&.destroy
      render json: return_object("OK")
    else
      render json: return_object("FAIL", "Failed to delete artist")
    end
  end

  protected

  def set_artist
    @artist = Artist.find_by(id: params[:id])
  end

  def artist_params
    params.require(:artist).permit(:name, :biography)
  end

  def return_object(status, payload = nil)
    {
      status: status,
      payload: payload
    }
  end
end
