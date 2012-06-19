class LoginsController < ApplicationController
	before_filter :only_when_user_is_logged_in, :only => :logout

	def index

		respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end
  
			
	def login
	
		respond_to do |format|
			if user = User.authenticate(params[:username], params[:password])
				session[:current_user] = user.username
				flash[:notice] = "You have logged in successfully!"
				format.html { redirect_to posts_path }
			else
				format.html { redirect_to login_path, notice: 'username or password is incorrect!'}
			end
		end
	end
	
	def logout
		session[:current_user] = nil
		redirect_to login_path
	end
end
