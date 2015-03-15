class RemoveViewLinkFromSettings < ActiveRecord::Migration
  def change
    remove_column :settings, :view_link, :string
  end
end
