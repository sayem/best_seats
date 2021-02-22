class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.string :title, unique: true, null: false
      t.text :summary, null: false
      t.integer :year, null: false
      t.string :genre, null: false
      t.string :imdb_link
      
      t.timestamps
    end
  end
end
