class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.integer :season
      t.integer :episode_number
      t.string :title
      t.date :airdate
      t.integer :show_id
    end
    add_index :episodes, :show_id
  end
end
