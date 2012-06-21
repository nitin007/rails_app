class CreateFollowships < ActiveRecord::Migration
  def change
    create_table :followships do |t|
      t.integer :user_id
      t.integer :following_id
      
      t.timestamps
    end
  end
end
