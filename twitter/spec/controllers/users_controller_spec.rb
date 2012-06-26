require 'spec_helper'

describe UsersController, :type => :controller do
	render_views
	
	before(:each) do
		@user = mock_model('User', :save => true)
		controller.stub!(:only_when_user_is_logged_in).and_return true
	end
		
	it "should render with new user to be registered" do
		get :new
		response.should be_success
	end
	
	context "create new user" do
		it "should redirect to tweets path on successful registeration" do
			User.stub!(:new).and_return @user
			post :create
			
			flash[:notice].should_not be_nil
			response.should redirect_to(tweets_path)
		end
		
		it "should re-render new template on failed registration" do
		  User.stub!(:new) {mock_model('User', :save => false)}
			post :create
      
			flash[:notice].should be_nil
			response.should render_template('new')
		end
	end
	
	it "should redirects to tweets path if user not found" do
		User.stub!(:find).with("3").and_return @user
		User.stub!(:find_by_username).and_return false
		get :show, :id => "3"
		response.should redirect_to tweets_path
	end
	
	it "should show details of user when show is called" do
		User.stub!(:find).and_return @user
		User.stub!(:find_by_username).and_return @user
		get :show, :id => "3"
		response.should be_success
	end
end
