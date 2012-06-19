require 'spec_helper'

describe Category do
	context "with its attributes empty" do
		it "should not be valid" do
			@category = Category.new
			@category.should_not be_valid
			@category.should have(1).error_on(:name)
		end
	end
	
	context "with its attributes filled" do
		it "should be valid" do
			@category = Category.new(:name => "rspec1")
			@category.should be_valid
		end
	end

	it "should have unique name" do
		@category1 = Category.new(:name => "rspec")
		@category1.should_not be_valid
#		@category1.save
		
#		@category2 = Category.new(:name => "rspec")
#		@category2.should_not be_valid		
		
#		@category1.destroy
	end
	
	context "association" do
		it "should be valid with posts" do
			@category = Category.new(:name => "rspec2")
			@category.should be_valid
			@category.save
			
			@post = @category.posts.new(:name => "nitin", :title => "rspec test", :description => "testing with rspec is fun", :user_id => 1)
			@post.should be_valid
#			@category.destroy
		end
	end
	
	context "when destroyed" do
		it "all posts under it are moved to default category" do
			@category = Category.new(:name => "rspec3")
			@category.should be_valid
			@category.save
			
			@post = @category.posts.new(:name => "nitin", :title => "rspec test", :description => "testing with rspec is fun", :user_id => 1)
			@post.should be_valid
			@post.save
			
			@category.destroy
			@post.reload
			@post.category_id.should == 1
			@post.destroy
		end
	end
	
#	it "should return default category when default_category is called" do
#		@category = Category.new
#		@category.instance_eval{ default_category }
#		@category.instance_eval{ @default_category.id }.should == 1
#	end
	
#	it "should assign default category to associated posts when assign_default_category is called" do
#		@category = Category.new(:name => "rspec")
#		@category.instance_eval{ assign_default_category }
#		@category.instance_eval{ @default_category.posts }.all.should include(@category.posts)
#	end
end
