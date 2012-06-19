class CreateTweetsUsers < ActiveRecord::Migration
  def change
    create_table :tweets_users do |t|
      t.integer :user_id
      t.integer :tweet_id

      t.timestamps
    end
  end
end
