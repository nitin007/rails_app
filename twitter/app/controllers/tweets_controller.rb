class TweetsController < ApplicationController
	before_filter :only_when_user_is_logged_in
	
	def index
		@tweet = current_user.tweets.new
		@followings = current_user.followships.count
		@followers = current_user.inverse_followings.count
		@tweet_user = TweetsUser.new
		
		@tweets = Tweet.find_by_sql("select tweets.id, message from tweets INNER JOIN tweets_users ON tweets_users.tweet_id = tweets.id where tweets_users.user_id = #{current_user.id} UNION select tweets.id, message from tweets_users INNER JOIN followships ON tweets_users.user_id = following_id INNER JOIN tweets ON tweets_users.tweet_id = tweets.id where followships.user_id = #{current_user.id} UNION select id, message from tweets where ttype = 'public'")
		
		respond_to do |format|
			format.html
		end
	end

	def create
	  @tweet = current_user.tweets.create(params[:tweet])

		respond_to do |format|
		  if @tweet.save
		    format.html { redirect_to tweets_path, notice: 'Tweet was successfully posted.' }
		  end
		end
	end
	
	def destroy
		begin
			@tweet = Tweet.find(params[:id])
		rescue ActiveRecord::RecordNotFound
			render :text => "Record Not Found"
		end
		
		@tweet.destroy
		respond_to do |format|		
			format.html { redirect_to tweets_path }
		end
	end
	
	def mine
		respond_to do |format|
			format.html
		end
	end
end	
