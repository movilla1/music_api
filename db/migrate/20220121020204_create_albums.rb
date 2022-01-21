class CreateAlbums < ActiveRecord::Migration[6.1]
  def change
    create_table :albums do |t|
      t.string :name
      t.integer :year
      t.string :album_art

      t.timestamps
    end
  end
end
