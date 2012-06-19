require 'spec_helper'

describe Admin::PostsController, :type => :controller do
	render_views
	fixtures :users
	
	before(:each) do
		@post = mock_model('Post')
		Post.stub!(:new).and_return(@post)		
		@post.stub!(:save).and_return(true)
		Post.stub!(:find).with("7") { @post }		

		@user = users(:one)
		session[:current_user] = @user.username
		session[:current_user_id] = @user.id
	end
  	
	it "shows all posts when index is called" do
		get :index
		response.should be_success
	end
	
	it "shows the post" do
		get :show, :id => 7
		response.should be_success
	end
	
	it "renders with an empty new post" do
		get :new
		response.should be_success
	end
	
	it "renders with desired post for editing" do
		get :edit, :id => 7
		response.should be_success
	end
	  
	context "creating a new post" do
		it "should redirect to saved post with a notice on successful save" do
			post :create
			flash[:notice].should_not be_nil
			response.should redirect_to(post_path(@post))
		end

		it "should re-render new template on failed save" do
			@post.stub!(:save).and_return(false)
		  post :create
		  flash[:notice].should be_nil
		  response.should render_template('new')
		end
	end
	
	context "updating a new post" do
		it "should redirect to updated post with a notice on successful update" do
			@post.stub!(:update_attributes).and_return(true)
			put 'update', :id => 7
			flash[:notice].should_not be_nil
			response.should be_redirect
		end
		
		it "should re-render edit template on failed update" do
			@post.stub!(:update_attributes).and_return(false)
			put :update, :id => 7
			flash[:notice].should be_nil
			response.should render_template('edit')
		end
	end
	
	context "destroying a post" do
		it "should render the index template on post destroys" do
			delete 'destroy', :id => 7
			response.should redirect_to(posts_path)
		end
	end
end	
