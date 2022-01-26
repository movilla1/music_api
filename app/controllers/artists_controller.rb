# frozen_string_literal: true

class ArtistsController < ApplicationController
  ARTIST_PAGE_SIZE = 10

  before_action :set_artist, except: %i[index create]

  def index
    render json: Artist.all.limit(ARTIST_PAGE_SIZE).offset(params[:page].to_i * ARTIST_PAGE_SIZE)
  end

  def show
    render json: @artist
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

  def return_object(status, message = nil)
    {
      status: status,
      message: message
    }
  end
end
