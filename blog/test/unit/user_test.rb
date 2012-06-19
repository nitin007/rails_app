require 'test_helper'
require 'digest/sha2'

class UserTest < ActiveSupport::TestCase
	fixtures :posts
	
  test "user attributes must not be empty" do
  	user = User.new
  	assert user.invalid?
  	assert user.errors[:username].any?
  	assert user.errors[:password].any?
  end
  
  test "username must be unique" do
  	user1 = User.new(:username => "nitin", :password => "12345678", :password_confirmation => "12345678")
  	assert user1.save
  	
    #FIX: validation on uniqueness is case sensitive. Please also check with NITIN
  	user2 = User.new(:username => "nitin", :password => "87654321", :password_confirmation => "87654321")
  	assert !user2.save
  	assert_equal "has already been taken", user2.errors[:username].join(';')
  	
  	user3 = User.new(:username => "Nitin", :password => "87654321", :password_confirmation => "87654321")
  	assert user3.save
  end
  
  test "password must be greater than or equal to 5 characters" do
  	user = User.new(:username => "nitin", :password => "1234", :password_confirmation => "1234")
  	assert user.invalid?
  	
  	user.password = "12345"
  	user.password_confirmation = "12345"
  	assert user.valid?
  	
  	user.password = "12345678"
  	user.password_confirmation = "12345678"
  	assert user.valid?
    #FIX: Also check with password having length > 5
  end
  
  test "password and password_confirmation must be equal" do
  	user = User.new(:username => "nitin", :password => "12345678", :password_confirmation => "12345679")
  	assert user.invalid?
  end
  
  #FIX: test "encrypt password before saving"
  test "encrypt password before saving" do
  	user = User.new(:username => "nitin", :password => "12345678")
  	user.save
    
  	assert_equal user.password, Digest::SHA512.hexdigest('12345678')
  end
  
  #FIX: Test should say 'test authenticate' instead of user is authenticated before login
  test "authenticate" do
  	user = User.new(:username => "nitin", :password => "12345678")
  	user.save
  	assert User.authenticate("nitin", "12345678"), "username or password is incorrect!"
 end
 
 #FIX: test missing for hash_password
 test "hash_password" do
 		user = User.new(:username => "nitin", :password => "12345678")
 		user.hash_password
 		
 		assert_equal user.password, Digest::SHA512.hexdigest('12345678')
 end
 
 #FIX: test missing for :posts associations
 test "creating posts for user" do
 		@post = posts(:one)
 		
 		user = User.new(:username => "nitin", :password => "12345678")
 		user.save
 		
 		post = user.posts.new(:name => @post.name, :title => @post.title, :description => @post.description)
 		post.save
 end
end
