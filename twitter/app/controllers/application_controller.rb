class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :my_tweets, :current_user, :public_user?
  
 	def current_user
		@current_user ||= User.find(session[:current_user_id])
	end
  
  def my_tweets
  	@my_tweets = Tweet.find_by_sql("select tweets.* from tweets where user_id = #{current_user.id} UNION  select tweets.* from tweets INNER JOIN tweets_users ON tweets.id = tweets_users.tweet_id where tweets_users.user_id = #{current_user.id}")
  end
  
  def public_user?
  	current_user.username.eql? "public_user"
  end
  
	private

		def only_when_user_is_logged_in
			redirect_to logins_path if !User.find_by_username(session[:current_user])
		end
end
