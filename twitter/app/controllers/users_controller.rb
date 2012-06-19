class UsersController < ApplicationController
	before_filter :only_when_user_is_logged_in, :only => :show

	def new
    @user = User.new

    respond_to do |format|
      format.html
    end
  end
		
	def create
	  @user = User.new(params[:user])

	  respond_to do |format|
	    if @user.save
	    	session[:current_user] = @user.username
	    	session[:current_user_id] = @user.id
	      format.html { redirect_to tweets_path, notice: 'You are successfully registered!' }
	    else
	      format.html { render :action => "new" }
	    end
	  end
	end
	
	def show
		respond_to do |format|
			format.html
		end
	end
end
