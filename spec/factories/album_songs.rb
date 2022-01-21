# == Schema Information
#
# Table name: album_songs
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  album_id   :bigint
#  song_id    :bigint           not null
#
# Indexes
#
#  index_album_songs_on_album_id  (album_id)
#  index_album_songs_on_song_id   (song_id)
#
# Foreign Keys
#
#  fk_rails_...  (song_id => songs.id)
#
FactoryBot.define do
  factory :album_song do
    album { "" }
    song { nil }
  end
end
