class CreateAlbumSongs < ActiveRecord::Migration[6.1]
  def change
    create_table :album_songs do |t|
      t.references :album
      t.references :song, null: false, foreign_key: true

      t.timestamps
    end
  end
end
