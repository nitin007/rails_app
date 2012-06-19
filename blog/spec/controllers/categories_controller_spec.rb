require 'spec_helper'

describe Admin::CategoriesController, :type => :controller do
	render_views
	fixtures :users	
	#	fixtures :categories
	
	before(:each) do
		@category = mock_model('Category')
		Category.stub!(:new).and_return(@category)		
		@category.stub!(:save).and_return(true)
		Category.stub!(:find).with("7") { @category }				
		
		@user = users(:one)
		session[:current_user] = @user.username
	end
  	
	it "shows all categories when index is called" do
		Category.stub!(:find).with(1) { @category }				
		get :index
		response.should be_success
	end
	
	it "renders with an empty new category" do
		get :new
		response.should be_success
	end
	
	it "renders with desired category for editing" do
		get :edit, id: 7
		response.should be_success
	end
	
	context "creating a new category" do
		it "should redirect to categories list with a notice on successful save" do
			post :create
			flash[:notice].should == "Category was successfully created."
			response.should redirect_to(categories_path)
		end

		it "should re-render new template on failed save" do
			@category.stub!(:save).and_return(false)		
		  post :create
		  flash[:notice].should == "Category cannot be empty!"
			response.should redirect_to(new_category_path)
		end
	end
	
	context "updating a new category" do
		it "should redirect to categories list with a notice on successful update" do
			@category.stub!(:update_attributes).and_return(true)
			put :update, :id => 7
			flash[:notice].should_not be_nil
			response.should redirect_to(categories_path)
		end
		
		it "should re-render edit template on failed update" do
			@category.stub!(:update_attributes).and_return(false)
			put :update, :id => 7
			flash[:notice].should be_nil
			response.should render_template('edit')
		end
	end
	
	context "destroying a category" do
		it "should render the index template on category destroys" do
			delete 'destroy', :id => 7
			response.should redirect_to(categories_path)	
		end
	end
end
