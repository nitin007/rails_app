require 'spec_helper'

describe LoginsController, :type => :controller do
	render_views
	
	before(:each) do
		@user = mock_model('User', {:username => 'nitin', :password => "abcdefghi" })
	end
	
	it "shows the index template with(login page)" do
		get :index
		response.should be_success
	end
			
	context "redirects user" do
		it "on successful login to posts path" do
			@user.stub!(:authenticate).and_return true
			post :login, :username => @user.username, :password => @user.password
			session[:current_user_id].should_not be_nil
			flash[:notice].should eq("You have logged in successfully!")
			response.should redirect_to(posts_path)		
		end
		
		it "on unsuccessful login to login_path" do
			@user.stub!(:authenticate).and_return false
			post :login, :username => @user.username, :password => ""
			session[:current_user].should be_nil
			flash[:notice].should == 'username or password is incorrect!'
			response.should redirect_to(login_path)
		end
	end
	
	it "should redirects user to login page on logout" do
		post :logout
		session[:current_user].should be_nil
		response.should redirect_to(login_path)
	end
end
