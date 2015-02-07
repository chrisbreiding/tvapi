class ChangeTvsourceIdToSourceId < ActiveRecord::Migration
  def change
    rename_column :shows, :tvsource_id, :source_id
  end
end
