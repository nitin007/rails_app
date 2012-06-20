require 'spec_helper'

describe TweetsController, :type => :controller do
	fixtures :users
	render_views
	
	before(:each) do
		@tweet = mock_model('Tweet')
		Tweet.stub!(:new).and_return(@tweet)
		@tweet.stub!(:save).and_return(true)
	 	@user = users(:one)

		session[:current_user] = @user.username
		session[:current_user_id] = @user.id
	end
		
	it "shows all follwers', user and public tweets when index is called" do
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
			Tweet.stub!(:find).with("3") { @tweet }
			delete :destroy, :id => "3"
			response.should redirect_to(tweets_path)
		end
	end
end
