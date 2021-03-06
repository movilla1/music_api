# frozen_string_literal: true

# == Schema Information
#
# Table name: albums
#
#  id         :bigint           not null, primary key
#  album_art  :string
#  name       :string
#  year       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Album < ApplicationRecord
  mount_uploader :album_art, AlbumArtUploader

  has_many :album_songs
  has_many :songs, through: :album_songs
  has_many :album_artists
  has_many :artists, through: :album_artists

  validates :name, presence: true, length: { minimum: 2 }

  accepts_nested_attributes_for :songs
end
