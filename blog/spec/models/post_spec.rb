require 'spec_helper'

describe Post do
	context "with its attributes empty" do
		it "should be invalid" do
			@post = Post.new
			@post.should_not be_valid
			@post.should have(1).error_on(:name)
			@post.should have(2).error_on(:title)
			@post.should have(1).error_on(:description)		
			@post.should have(1).error_on(:category_id)
		end
	end
	
	context "with its attributes filled" do
		it "should be valid" do
			@post = Post.new(:name => "nitin", :title => "rspec test", :description => "testing with rspec is fun", :category_id => 1)
			@post.should be_valid
		end
	end
	
	context "title has greater than or equal to 5 characters" do
		it "should be valid" do
			@post = Post.new(:name => "nitin", :title => "rspc", :description => "testing with rspec is fun", :category_id => 1)
			@post.should_not be_valid
			
			@post.title = "rspec"
			@post.should be_valid			
			
			@post.title = "rspec test"
			@post.should be_valid			
		end
	end		
	
	context "association" do
		it "should be valid with category" do
			@category = Category.new(:name => "test")
			@category.should be_valid
			@category.save
			
			@post = @category.posts.new(:name => "nitin", :title => "rspec test", :description => "testing with rspec is fun", :user_id => 1)
			@post.should be_valid
#			@category.destroy
		end
		
		it "should be valid with user" do
			@user = User.new(:username => "nitin1", :password => "nitin1")
			@user.should be_valid
			@user.save
			
			@post = @user.posts.new(:name => "nitin", :title => "rspec test", :description => "testing with rspec is fun", :category_id => 1)
			@post.should be_valid
			@user.destroy
		end
		
		it "should be valid with comments" do
			@post = Post.new(:name => "nitin", :title => "rspec test", :description => "testing with rspec is fun", :category_id => 1, :user_id => 1)
			@post.should be_valid
			@post.save
			
			@comment = @post.comments.new(:commenter => "nitin", :body => "this is a test")
			@comment.should be_valid
			@post.destroy
		end
	end
	
	context "destroys" do
		it "should destroys associated comments" do
			@post = Post.new(:name => "nitin", :title => "rspec test", :description => "testing with rspec is fun", :category_id => 1, :user_id => 1)
			@post.should be_valid
			@post.save
			
			@comment = @post.comments.new(:commenter => "nitin", :body => "this is a test")
			@comment.should be_valid
			@comment.save
			
			@post.destroy
			Comment.all.should_not include(@comment)
		end
	end
end	
