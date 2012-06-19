class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user
  
  def current_user
  	@current_user ||= User.find_by_username(session[:current_user])
  end
  
  private
  
		def only_when_user_is_logged_in
			redirect_to login_path if !User.find_by_username(session[:current_user])
		end
end
