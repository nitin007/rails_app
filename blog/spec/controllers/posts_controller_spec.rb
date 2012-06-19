require 'spec_helper'

describe Admin::PostsController, :type => :controller do
	render_views
	fixtures :posts
	fixtures :categories
	fixtures :users
	
	before(:each) do
		@post = posts(:one)
		@category = categories(:one)
		@user = users(:one)
		session[:current_user] = @user.username
		session[:current_user_id] = @user.id
	end
  	
	it "shows all posts when index is called" do
		get :index
		response.should be_success
		assigns(:posts).should eq(Post.all)
	end
	
	it "shows the post" do
		get :show, :id => @post.id
		response.should be_success
		assigns(:post).should eq(@post)
	end
	
	it "renders with an empty new post" do
		get :new
		response.should be_success
	end
	
	it "renders with desired post for editing" do
		get :edit, :id => @post.id
		response.should be_success
		assigns(:post).should eq(@post)
	end
	  
	context "creating a new post" do
		it "should redirect to saved post with a notice on successful save" do
			post 'create', :post => {:name => "nitin", :title => "rspec test", :description => "kjdsgf", :category_id => @category.id, :user_id => @user.id}
			flash[:notice].should_not be_nil
			response.should be_redirect
		end

		it "should re-render new template on failed save" do
		  post 'create', :post => {}
		  flash[:notice].should be_nil
		  response.should render_template('new')
		end
	end
	
	context "updating a new post" do
		it "should redirect to updated post with a notice on successful update" do
			put 'update', :id => @post.id
			flash[:notice].should_not be_nil
			response.should be_redirect
		end
		
		it "should re-render edit template on failed update" do
			put :update, :id => @post.id, :post => {:name => ""}
			flash[:notice].should be_nil
			response.should render_template('edit')
		end
	end
	
	context "destroying a post" do
		it "should render the index template on post destroys" do
			delete 'destroy', :id => @post.id
			response.should redirect_to(posts_path)
		end
	end
end	
