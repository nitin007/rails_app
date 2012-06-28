class TweetsController < ApplicationController
  # TODO: WA: Test this controller more thoroughly.
	before_filter :only_when_user_is_logged_in
	
	def index
		@tweet = current_user.tweets.new
		@followings = current_user.followings.count
		@followers = current_user.inverse_followings.count
		@tweet_user = TweetsUser.new
		
    # OPTIMIZE: WA: Sort the results in SQL itself. Using ruby's sort
    # is very inefficient.
    #
    # REFACTOR: Move following SQL find to Tweet model in its own method
    # and write tests for it.
		@tweets = Tweet.find_by_sql("select tweets.* from tweets where user_id = #{current_user.id} UNION select tweets.* from tweets_users INNER JOIN follows ON tweets_users.user_id = following_id INNER JOIN tweets ON tweets_users.tweet_id = tweets.id where follows.user_id = #{current_user.id} UNION select tweets.* from tweets INNER JOIN follows ON tweets.user_id = follows.following_id where follows.user_id = #{current_user.id} UNION select * from tweets where ttype = 'public'").sort.reverse
				
		respond_to do |format|
			format.html
		end
	end

	def create
	  @tweet = current_user.tweets.build(params[:tweet])

		respond_to do |format|
		  if @tweet.save
		    format.html { redirect_to tweets_path, notice: 'Tweet was successfully posted.' }
		  else
		  	render :text => "Tweet was not saved successfully!"
		  end
		end
	end
	
  # TODO: WA: Write thorough tests for following action
	def destroy
		begin
			@tweet = current_user.tweets.find(params[:id])
		rescue ActiveRecord::RecordNotFound
			render :text => "Record Not Found"
		end
		
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
