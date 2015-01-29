class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.string :display_name
      t.string :search_name
      t.string :file_name
      t.string :tvsource_id
    end
  end
end
