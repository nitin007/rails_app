class RenameOldTableToNewTable < ActiveRecord::Migration
  def up
  	rename_table :followships, :follows
  end

  def down
  	rename_table :follows, :followships
  end
end
