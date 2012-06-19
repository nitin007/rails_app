require 'spec_helper'

describe TweetsUsersController, :type => :controller do
	render_views
	
	before(:each) do
		@tweets_user = mock_model('TweetsUser')
		TweetsUser.stub!(:new).and_return(@tweets_user)
		@tweets_user.stub!(:save).and_return(true)
	end
	
	context "create entry for tweet which is created or retweeted" do
		it "should redirect to tweets path" do
			post :create
			flash[:notice].should_not be_nil
			response.should redirect_to(tweets_path)
		end
	end
	
	it "should destroys entry from relationship model when undo retweet or tweet deleted" do
		TweetsUser.stub!(:find).with("3") { @tweets_user }
		delete :destroy, :id => "3"
	end
end
