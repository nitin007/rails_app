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
		it "should redirect to tweets path" do
			post :create
			response.should redirect_to(tweets_path)
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
