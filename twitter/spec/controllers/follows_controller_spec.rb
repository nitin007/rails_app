require 'spec_helper'

describe FollowsController, :type => :controller do
	render_views
	
	before(:each) do
		controller.stub!(:only_when_user_is_logged_in).and_return true
		@user = mock_model('User')
		@follow = mock_model('Follow')
		User.stub!(:find).and_return @user
		
		@user.stub!(:follows).and_return true
		@user.follows.stub!(:build).and_return @follow
		@follow.stub!(:save).and_return true
	end
		
	it "shows list of users when index is called" do
		@user.follows.stub!(:find_by_following_id).and_return true
		get :index
		response.should be_success
	end
	
	context "creates new follow relationship" do
		it "should redirect to whoToFollow path" do
			post :create
			response.should redirect_to (whoToFollow_path)
		end
		
		it "should render text when not saved" do
			@follow.stub!(:save).and_return false
			post :create
			response.should render_template(:text => "Follow was not created." )
		end
	end
	
	context "destroys a followship" do
		it "should redirect to whoToFollow path" do
			@user.stub!(:followings).and_return true
			@user.followings.stub!(:find).with("7").and_return @follow
			delete :destroy, :id => "7"
			response.should redirect_to(whoToFollow_path)			
		end
	end
end
