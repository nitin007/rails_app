require 'spec_helper'

describe Comment do
	context "association with post" do
		it "should be valid" do
			@post = Post.new(:name => "nitin", :title => "rspec test", :description => "testing with rspec is fun", :user_id => 1, :category_id => 1)
			@post.should be_valid
			@post.save
			
			@comment = @post.comments.new(:commenter => "nitin", :body => "this is a test")
			@comment.should be_valid
			
			@post.destroy
		end
	end
end
