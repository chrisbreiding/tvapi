class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :view_link
      t.datetime :last_updated
    end
  end
end
