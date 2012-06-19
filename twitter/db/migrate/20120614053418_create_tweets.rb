class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :message
      t.string :ttype

      t.timestamps
    end
  end
end
