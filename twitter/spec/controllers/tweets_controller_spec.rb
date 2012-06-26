require 'spec_helper'

describe TweetsController, :type => :controller do
	render_views
	
	before(:each) do
		controller.stub!(:only_when_user_is_logged_in).and_return true	

		@user = mock_model('User')
		@tweet = mock_model('Tweet', :save => true)
		
		User.stub!(:find).and_return @user
		@user.stub!(:tweets).and_return true
		@user.tweets.stub!(:build).and_return @tweet
		@user.tweets.stub!(:new).and_return @tweet
		@tweet.stub!(:save).and_return true		
		
		@my_tweets = (1..5).collect { mock_model("Tweet") }
		@my_tweets.stub!(:count).and_return true
		@my_tweets.stub!(:each).and_return true
		
		controller.stub!(:my_tweets).and_return @my_tweets
	end
		
	it "shows all followers', user and public tweets when index is called" do
		@user.stub_chain(:followings, :count).and_return true
		@user.stub_chain(:inverse_followings, :count).and_return true

		get :index
		response.should be_success
	end
	
	it "shows user tweets when mine is called" do
		get :mine
		response.should be_success
	end
	
	context "creates a new tweet" do
		it "should redirect to tweets path if saved successfully" do
			post :create
			response.should redirect_to(tweets_path)
		end
		
		it "should render index if not saved successfully" do
			@tweet.stub!(:save).and_return false
			post :create
			response.should render_template :text => "Tweet not saved successfully"
		end
	end
	
	context "destroys a tweet" do
		it "should redirect to tweets path" do
			@user.tweets.stub!(:find).with("7").and_return @tweet
			delete :destroy, :id => "7"
			response.should redirect_to(tweets_path)
		end
		
		it "should display with record not found when tweet not found" do
			@user.tweets.stub!(:find).and_return ActiveRecord::RecordNotFound
			delete :destroy, :id => "2"
			response.should render_template(:text => "Record Not Found")
		end
	end
end
