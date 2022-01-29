# frozen_string_literal: true

class SongsController < ApplicationController
  before_action :set_song, except: %i[index create]

  SONGS_PAGE_SIZE = 11

  def index
    songs = Song.all.limit(SONGS_PAGE_SIZE).offset(params[:page].to_i * SONGS_PAGE_SIZE)
    render json: song_object_response("OK", songs)
  end

  def show
    render json: song_object_response("OK", @song)
  end

  def create
    song = Song.new(song_params)
    if song.save
      render json: song_object_response("OK", "Song created properly")
    else
      render json: song_object_response("FAIL", "Falied to create Song properly")
    end
  end

  def update
    if @song&.update(song_params)
      render json: song_object_response("OK", "Song updated properly")
    else
      render json: song_object_response("FAIL", "Falied to update Song properly")
    end
  end

  def destroy
    if @song.present? && @song.destroy!
      render json: song_object_response("OK", "Song deleted properly")
    else
      render json: song_object_response("FAIL", "Failed to delete the song")
    end
  end

  private

  def set_song
    @song = Song.find_by(id: params[:id])
  end

  def song_params
    params.require(:song).permit(:name, :duration, :genre, :track_numb, :featured)
  end

  def song_object_response(status, payload)
    {
      status: status,
      payload: payload
    }
  end
end
