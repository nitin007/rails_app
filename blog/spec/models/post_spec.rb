require 'spec_helper'


describe Post do
	fixtures :users
	fixtures :categories
	fixtures :posts
	
	before(:each) do
		@post = posts(:one)		
		@category = categories(:one)		
		@user = users(:one)
		@comment = mock_model('Comment', {:body => "this is test", :commenter => "rspec"})				
	end
	
	context "with its attributes empty" do
		it "should be invalid" do
			@post1 = Post.new
			@post1.should_not be_valid
			@post1.should have(1).error_on(:name)
			@post1.should have(2).error_on(:title)
			@post1.should have(1).error_on(:description)		
			@post1.should have(1).error_on(:category_id)
		end
	end
	
	context "with its attributes filled" do
		it "should be valid" do
			@post1 = Post.new(:name => @post.name, :title => @post.title, :description => @post.description, :category_id => @post.category_id)
			@post1.should be_valid
		end
	end
	
	context "title has greater than or equal to 5 characters" do
		it "should be valid" do
			@post.title = "test"
			@post.should_not be_valid
			
			@post.title = "rspec"
			@post.should be_valid			
			
			@post.title = "rspec test"
			@post.should be_valid			
		end
	end		
	
	context "association" do
		it "should be valid with category" do
			@post1 = @category.posts.new(:name => @post.name, :description => @post.description, :title => @post.title, :user_id => @post.user_id)
			@post1.should be_valid
		end
		
		it "should be valid with user" do			
			@post1 = @user.posts.new(:name => @post.name, :description => @post.description, :title => @post.title, :category_id => @post.category_id)
			@post1.should be_valid
		end
		
		it "should be valid with comments" do			
			@comment = @post.comments.new(:commenter => @comment.commenter, :body => @comment.body)
			@comment.should be_valid
		end
	end
	
	context "destroys" do
		it "should destroys associated comments" do
			@comment = @post.comments.new(:commenter => "nitin", :body => "this is a test")
			@comment.save
			
			@post.destroy
			Comment.all.should_not include(@comment)
		end
	end
end	
