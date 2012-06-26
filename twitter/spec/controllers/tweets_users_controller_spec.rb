require 'spec_helper'

describe TweetsUsersController, :type => :controller do
	render_views
	
	before(:each) do
		controller.stub!(:only_when_user_is_logged_in).and_return true
		@user = mock_model('User')
		@retweet = mock_model('TweetsUser')
		User.stub!(:find).and_return @user
		@user.stub!(:tweets_users).and_return true
		
		@user.tweets_users.stub!(:new).and_return @retweet
		@retweet.stub!(:save).and_return true
	end
	
	context "create retweet" do
		it "should redirect to tweets path if successfully saved" do
			post :create
			flash[:notice].should_not be_nil
			response.should redirect_to(tweets_path)
		end
		
		it "should render some text if not saved successfully" do
			@retweet.stub!(:save).and_return false
			post :create
			flash[:notice].should be_nil
			response.should render_template(:text => "tweet was not saved successfully")
		end
	end
	
	it "should destroys when undo retweet or tweet deleted" do
		@user.tweets_users.stub!(:find).with("1").and_return @retweet
		delete :destroy, :id => "1"
		response.should redirect_to tweets_path
	end
end
