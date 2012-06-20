require 'spec_helper'

describe TweetsUsersController, :type => :controller do
	render_views
	
	before(:each) do
		@tweets_user = mock_model('TweetsUser')
		TweetsUser.stub!(:new).and_return(@tweets_user)
		@tweets_user.stub!(:save).and_return(true)
	end
	
	context "create tweet or retweet" do
		it "should redirect to tweets path if successfully saved" do
			post :create
			flash[:notice].should_not be_nil
			response.should redirect_to(tweets_path)
		end
		
		it "should render some text if not saved successfully" do
			@tweets_user.stub!(:save).and_return false
			post :create
			flash[:notice].should be_nil
			response.should render_template(:text => "tweet was not saved successfully")
		end
	end
	
	it "should destroys when undo retweet or tweet deleted" do
		TweetsUser.stub!(:find).and_return @tweets_user
		delete :destroy
		response.should redirect_to tweets_path
	end
end
