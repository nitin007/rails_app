class Admin::PostsController < ApplicationController
	before_filter :only_when_user_is_logged_in, :only => [:new, :edit]
	
  def index
    @posts = Post.paginate(:per_page => 5, :page => params[:page])

    respond_to do |format|
      format.html
    end
  end
  
  def show  
		begin
			@post = Post.find(params[:id])
		rescue ActiveRecord::RecordNotFound
			render :file => "#{Rails.root}/public/recordnotfound.html", :layout => false and return
		end
		respond_to do |format|
			format.html
			format.json { render json: @post }
		end
  end

  def new
    @post = Post.new
    respond_to do |format|
      format.html 
    end
  end

  def edit
		begin
			@post = Post.find(params[:id])
		rescue ActiveRecord::RecordNotFound
			render :file => "#{Rails.root}/public/recordnotfound.html", :layout => false
		end
  end

  def create
    @post = Post.new(params[:post])
    
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end
end
