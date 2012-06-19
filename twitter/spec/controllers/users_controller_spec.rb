require 'spec_helper'

describe UsersController, :type => :controller do
	render_views
		
	it "should render with new user to be registered" do
		get :new
		response.should be_success
	end
	
	context "create new user" do
		it "should redirect to tweets path on successful registeration" do
		  User.stub!(:new) {mock_model('User', :save => true)}
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
	
	it "should show details of user when show is called" do
		@user = mock_model("User")
		User.stub!(:find).with("nitin") { @user }
		get :show, :username => "nitin"
	end
end
