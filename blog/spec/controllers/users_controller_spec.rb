require 'spec_helper'

describe UsersController, :type => :controller do
	render_views
	
	it "shows the index template with(login page)" do
		get :index
		response.should be_success
	end
		
#	context "registering a new user" do
		it "creates a new user" do
			post 'create', :user => {:username => "nitin", :password => "nitin", :password_confirmation => "nitin"}
#			flash[:notice].should_not be_nil
#			response.should redirect_to(posts_path)
		end
#	end
	
	context "redirects user" do
		it "on successful login to posts path" do
			post 'login', :username => "nitin", :password => "nitin"
			session[:current_user].should_not be_nil
			flash[:notice].should == "You have logged in successfully!"
			response.should redirect_to(posts_path)
		end
		
		it "on unsuccessful login to login_path" do
			post :login, :username => "nitin", :password => "abcdef"
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
