require 'spec_helper'

describe Category do
	fixtures :categories
	fixtures :posts
	
	before(:each) do
		@category = categories(:one)
		@post = posts(:two)
	end
	
	context "with its attributes empty" do
		it "should not be valid" do
			@category1 = Category.new
			@category1.should_not be_valid
			@category1.should have(1).error_on(:name)
		end
	end
	
	context "with its attributes filled" do
		it "should be valid" do
			@category1 = Category.new(:name => "rspec lib")
			@category1.should be_valid
		end
	end

	it "should have unique name" do
		@category1 = Category.new(:name => @category.name)
		@category1.should_not be_valid
	end
	
	context "association" do
		it "should be valid with posts" do
			@post1 = @category.posts.new(:name => @post.name, :title => @post.title, :description => @post.description, :category_id => @post.category_id)
			@post1.should be_valid
		end
	end
	
	context "when destroyed" do
		it "all posts under it are moved to default category" do			
			@post1 = @category.posts.new(:name => @post.name, :title => @post.title, :description => @post.description, :category_id => @post.category_id, :user_id => @post.user_id)
			@post1.save
			
			@category.destroy
			@post1.reload
			@post1.category_id.should eql(1)
		end
	end
end
