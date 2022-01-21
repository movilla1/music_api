# frozen_string_literal: true

# == Schema Information
#
# Table name: artists
#
#  id         :bigint           not null, primary key
#  biography  :text
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Artist < ApplicationRecord
  has_many :artist_songs
  has_many :songs, through: :artist_songs
  has_many :album_artists
  has_many :albums, through: :album_artists

  validates :name, presence: true
end
