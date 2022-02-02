# == Schema Information
#
# Table name: artist_songs
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  artist_id  :bigint           not null
#  song_id    :bigint           not null
#
# Indexes
#
#  index_artist_songs_on_artist_id  (artist_id)
#  index_artist_songs_on_song_id    (song_id)
#
# Foreign Keys
#
#  fk_rails_...  (artist_id => artists.id)
#  fk_rails_...  (song_id => songs.id)
#
FactoryBot.define do
  factory :artist_song do
    artist { nil }
    song { nil }
  end
end
