class CreateFollowships < ActiveRecord::Migration
  def change
    create_table :followships do |t|
      t.integer :user_id
      t.integer :follower_id
      t.string :create
      t.string :destroy

      t.timestamps
    end
  end
end
