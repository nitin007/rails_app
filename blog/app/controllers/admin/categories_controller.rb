class Admin::CategoriesController < ApplicationController
	before_filter :only_when_user_is_logged_in

	def index
		@categories = Category.all
		@default_category = Category.find(1).name
		respond_to do |format|
      format.html
    end
	end

	def edit
		if Category.exists?(params[:id])
			@category = Category.find(params[:id])
		else
			render :file => "#{Rails.root}/public/recordnotfound.html", :layout => false
		end	
	end

	def new
		@category = Category.new
		
		respond_to do |format|
		  format.html
		end
	end
	
	def update
		@category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to categories_path, notice: 'Category was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
	end
	
	def destroy
		@category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to categories_url }
    end
	end
	
	def create
		@category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        format.html { redirect_to categories_path, notice: 'Category was successfully created.' }
      else
        format.html { redirect_to new_category_path,  notice: 'Category cannot be empty!'}
      end
    end
	end
end
