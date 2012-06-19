require 'spec_helper'

describe Comment do
	fixtures :posts
	fixtures :comments
	
	before do
		@post = posts(:one)
		@comment = comments(:one)
	end
	
	context "association with post" do
		it "should be valid" do
			@comment = @post.comments.new(:commenter => @comment.commenter, :body => @comment.body)
			@comment.should be_valid
		end
	end
end
