class CreateSongs < ActiveRecord::Migration[6.1]
  def change
    create_table :songs do |t|
      t.string :name
      t.integer :duration
      t.integer :genre
      t.integer :track_numb
      t.boolean :featured

      t.timestamps
    end
  end
end
