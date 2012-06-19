class FixColumnName < ActiveRecord::Migration
  def up
  	rename_column :followships, :follower_to_id, :followerTo_id
  end

  def down
  end
end
