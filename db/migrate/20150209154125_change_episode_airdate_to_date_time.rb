class ChangeEpisodeAirdateToDateTime < ActiveRecord::Migration
  def up
    change_column :episodes, :airdate, :datetime
  end

  def down
    change_column :episodes, :airdate, :date
  end
end
