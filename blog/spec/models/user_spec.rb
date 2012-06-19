require 'spec_helper'
require 'digest/sha2'

describe User do
	fixtures :users
	fixtures :posts
	
	before(:each) do
		@post = posts(:two)		
		@user = users(:one)
	end	
	
	context "with its attributes empty" do
		it "should_not be_valid" do
			@user = User.new
			@user.should_not be_valid
			@user.should have(1).error_on(:username)
			@user.should have(2).error_on(:password)
		end
	end
	
	context "with its attributes filled" do
		it "should be valid" do
			@user = User.new(:username => "nitin1", :password => @user.password, :password_confirmation => @user.password)
			@user.should be_valid
		end
	end
	
	context "with its username" do
		it "should be unique" do
			@user1 = User.new(:username => @user.username, :password => @user.password, :password_confirmation => @user.password)
			@user1.should_not be_valid
		end
	end
	
	context "password" do
		it "should be greater than or equal to 5 characters" do
			@user1 = User.new(:username => "nitin1", :password => "abcd", :password_confirmation => "abcd")
			@user1.should_not be_valid
			
			@user1.password = "abcde"
			@user1.password_confirmation = "abcde"
			@user1.should be_valid
			
			@user1.password = "abcdefgt"
			@user1.password_confirmation = "abcdefgt"			
			@user1.should be_valid
		end
	
		it "should be equal to password_confirmation" do
			@user1 = User.new(:username => "nitin1", :password => @user.password)
			@user1.password_confirmation = "abcdef"
			@user1.should_not be_valid
			
			@user1.password_confirmation = @user.password
			@user1.should be_valid
		end
	
		it "should be hashed before saving to database" do
			@user1 = User.new(:username => "nitin1", :password => @user.password, :password_confirmation => @user.password)
			@user1.save
			@user1.password.should be == Digest::SHA512.hexdigest(@user.password)
		end
		
		it "should be hashed" do
			@user1 = User.new
			@user1.password = @user.password
			@user1.hash_password
			
			@user1.password.should == Digest::SHA512.hexdigest(@user.password)
		end
	end
	
	it "authenticates" do
		@user1 = User.new(:username => "nitin", :password => @user.password, :password_confirmation => @user.password)
		@user1.save
		
		User.authenticate(@user1.username, '12345678').should eql(nil)
		User.authenticate(@user1.username, @user.password).should be_valid
	end
	
	context "association" do
		it "should be valid" do			
			@post1 = @user.posts.new(:name => @post.name, :title => @post.title, :description => @post.description, :category_id => @post.category_id)
			@post1.should be_valid
		end
	end
	
	context "destroys" do
		it "should destroy associated posts" do
			@post1 = @user.posts.new(:name => @post.name, :title => @post.title, :description => @post.description, :category_id => @post.category_id)
			@post1.save
			@user.destroy
			
			Post.all.should_not include(@post1)
		end
	end
end
