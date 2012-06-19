require 'spec_helper'

describe Admin::CommentsController, :type => :controller do
	render_views
	
	before(:each) do
		@post = mock_model('Post')
		Post.stub!(:find).with("7").and_return(@post)
		
		@comment = mock_model('Comment')
		@post.stub!(:comments).and_return @comment
		@post.comments.stub!(:create).and_return(true)
		@post.comments.stub!(:find).with("2").and_return(@comment)
	end
	
	context "creating a new comment" do
		it "should redirect to to post" do
			post :create, :post_id => 7
			response.should redirect_to(@post)
		end
	end
	
	context "destroying a comment" do
		it "should redirect to post on destroys" do
			delete :destroy, :post_id => 7, :id => 2
			response.should redirect_to(@post)	
		end
	end
end
