require 'spec_helper'

describe Admin::CommentsController, :type => :controller do
	render_views
	fixtures :comments
	fixtures :posts	
	
	before(:each) do
		@comment = comments(:one)
		@post = posts(:one)
	end
	
	context "creating a new comment" do
		it "should redirect to to post" do
			post :create, :comment => {:commenter => @comment.commenter, :body => @comment.body}, :post_id => @post.id
			response.should redirect_to(@post)
		end
	end
	
	context "destroying a comment" do
		it "should redirect to post on destroys" do
			delete :destroy, :id => @comment.id, :post_id => @post.id
			response.should redirect_to(@post)	
		end
	end
end
