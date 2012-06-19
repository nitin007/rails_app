require 'spec_helper'

describe FollowshipsController, :type => :controller do
	fixtures :users
	render_views
	
	before(:each) do
		@followship = mock_model('Followship')
		Followship.stub!(:new).and_return(@followship)
		@followship.stub!(:save).and_return(true)
		
		@user = users(:one)
		session[:current_user] = @user.username
		session[:current_user_id] = @user.id
	end
		
	it "shows list of users when index is called" do
		get :index
		response.should be_success
	end
	
	context "creates new followship" do
		it "should redirect to whoToFollow path" do
			post :create
			response.should redirect_to (whoToFollow_path)
		end
	end
	
	context "destroys a followship" do
		it "should redirect to whoToFollow path" do
			Followship.stub!(:find).with("7") { @followship }
			delete :destroy, :id => "7"
			response.should redirect_to(whoToFollow_path)			
		end
	end
end
