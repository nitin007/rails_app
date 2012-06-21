class TweetsController < ApplicationController
	before_filter :only_when_user_is_logged_in
	
	def index
		@tweet = Tweet.new
		@followings = current_user.followships.count
		@followers = current_user.inverse_followings.count
		@tweet_user = TweetsUser.new
		
    # FIXME: WA: Following fetches tweets in the order those
    # were created. Fetch the earliest tweet first.
    # Fixed: NG: I am not fetching in order tweets were created! 
    # instead i am fetching all public, followings and current user's tweets.
		@tweets = Tweet.find_by_sql("select tweets.* from tweets where user_id = #{current_user.id} UNION select tweets.* from tweets_users INNER JOIN followships ON tweets_users.user_id = following_id INNER JOIN tweets ON tweets_users.tweet_id = tweets.id where followships.user_id = #{current_user.id} UNION select tweets.* from tweets INNER JOIN followships ON tweets.user_id = followships.following_id where followships.user_id = #{current_user.id} UNION select * from tweets where ttype = 'public'")
		
		respond_to do |format|
			format.html
		end
	end

	def create
	  @tweet = Tweet.create(params[:tweet])

		respond_to do |format|
      # FIXME: WA: What if tweet was not saved.
      #Fixed: NG
		  if @tweet.save
		    format.html { redirect_to tweets_path, notice: 'Tweet was successfully posted.' }
		  else
		  	render :text => "Tweet was not saved successfully!"
		  end
		end
	end
	
	def destroy
		begin
			@tweet = Tweet.find(params[:id])
		rescue ActiveRecord::RecordNotFound
			render :text => "Record Not Found"
		end
		
    # FIXME: WA: What if tweet was not destroyed.
    #Fixed: NG
		@tweet.destroy
		render :text => "Tweet was not deleted!" and return if !@tweet.destroy
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
