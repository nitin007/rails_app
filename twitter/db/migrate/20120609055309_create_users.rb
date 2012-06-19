class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :fullname
      t.string :email
      t.string :username
      t.string :password
      t.string :password_digest

      t.timestamps
      
      add_index :users, :slug, unique: true
    end
  end
end
