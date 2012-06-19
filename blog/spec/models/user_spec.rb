require 'spec_helper'
require 'digest/sha2'

describe User do
	context "with its attributes empty" do
		it "should_not be_valid" do
			@user = User.new
			@user.should_not be_valid
			@user.should have(1).error_on(:username)
			@user.should have(2).error_on(:password)
			@user.should have(0).error_on(:password_confirmation)
		end
	end
	
	context "with its attributes filled" do
		it "should be valid" do
			@user = User.new(:username => "nitin1", :password => "abcdef", :password_confirmation => "abcdef")
			@user.should be_valid
		end
	end
	
	context "with its username" do
		it "should be unique" do
			@user1 = User.new(:username => "nitin", :password => "abcdef", :password_confirmation => "abcdef")
			@user1.should_not be_valid
#			@user1.save
			
#			@user2 = User.new(:username => "nitin", :password => "ghijkl", :password_confirmation => "ghijkl")
#			@user2.should_not be_valid

#			@user1.destroy
		end
	end
	
	context "password" do
		it "should be greater than or equal to 5 characters" do
			@user = User.new(:username => "nitin1", :password => "abcd", :password_confirmation => "abcd")
			@user.should_not be_valid
			
			@user.password = "abcde"
			@user.password_confirmation = "abcde"
			@user.should be_valid
			
			@user.password = "abcdefgt"
			@user.password_confirmation = "abcdefgt"			
			@user.should be_valid
		end
	
		it "should be equal to password_confirmation" do
			@user = User.new(:username => "nitin1", :password => "abcdef", :password_confirmation => "abcdeg")
			@user.should_not be_valid
			
			@user = User.new(:username => "nitin1", :password => "abcdef", :password_confirmation => "abcdef")
			@user.should be_valid
		end
	
		it "should be hashed before saving to database" do
			@user = User.new(:username => "nitin1", :password => "abcdef", :password_confirmation => "abcdef")
			@user.should be_valid
			@user.save
			@user.password.should be == Digest::SHA512.hexdigest('abcdef')
			@user.destroy
		end
		
		it "should be hashed" do
			@user = User.new
			@user.password = "abcdef"
			@user.hash_password
			
			@user.password.should == Digest::SHA512.hexdigest('abcdef')
		end
	end
	
	it "authenticates" do
		@user = User.new(:username => "nitin1", :password => "abcdef", :password_confirmation => "abcdef")
		@user.should be_valid
		@user.save
		User.authenticate(@user.username, '12345678').should == nil
		User.authenticate(@user.username, 'abcdef').should be_valid
		@user.destroy
	end
	
	context "association" do
		it "should be valid" do
			@user = User.new(:username => "nitin1", :password => "abcdef", :password_confirmation => "abcdef")
			@user.should be_valid
			@user.save
			
			@post = @user.posts.new(:name => "nitin", :title => "rspec test", :description => "testing with rspec is fun", :category_id => 1)
			@post.should be_valid
			@user.destroy
		end
	end
	
	context "destroys" do
		it "should destroy associated posts" do
			@user = User.new(:username => "nitin1", :password => "abcdef", :password_confirmation => "abcdef")
			@user.should be_valid
			@user.save
			
			@post = @user.posts.new(:name => "nitin", :title => "rspec test", :description => "testing with rspec is fun", :category_id => 1)
			@post.should be_valid
			@user.destroy
			
			Post.all.should_not include(@post)
		end
	end
end
