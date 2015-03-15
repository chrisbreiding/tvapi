class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :api_key
      t.string :view_link
    end
  end
end
