class CreateViewerships < ActiveRecord::Migration
  def change
    create_table :viewerships do |t|
      t.belongs_to :user, index: true
      t.belongs_to :show, index: true
    end
  end
end
