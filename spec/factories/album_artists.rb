# == Schema Information
#
# Table name: album_artists
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  album_id   :bigint           not null
#  artist_id  :bigint           not null
#
# Indexes
#
#  index_album_artists_on_album_id   (album_id)
#  index_album_artists_on_artist_id  (artist_id)
#
# Foreign Keys
#
#  fk_rails_...  (album_id => albums.id)
#  fk_rails_...  (artist_id => artists.id)
#
FactoryBot.define do
  factory :album_artist do
    album { nil }
    artist { nil }
  end
end
