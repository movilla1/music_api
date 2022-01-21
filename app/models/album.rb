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

  validates :name, presence: true, length: { minimum: 2 }
end
