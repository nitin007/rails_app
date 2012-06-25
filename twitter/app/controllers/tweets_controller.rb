class TweetsController < ApplicationController
  # TODO: WA: Test this controller more thoroughly.
	before_filter :only_when_user_is_logged_in
	
	def index
		@tweet = current_user.tweets.new
		@followings = current_user.followings.count
		@followers = current_user.inverse_followings.count
		@tweet_user = TweetsUser.new
		
    # FIXME: WA: Following fetches tweets in the order those
    # were created. Fetch the earliest tweet first.
    # Fixed: NG: I am not fetching in order tweets were created! 
    # instead i am fetching all public, followings and current user's tweets.

    # TODO: WA: The tweets will be fetched in the order they
    # were created. Even if you do not specify any order.
    # Because of this old tweets in the user's timeline appear
    # above new tweets. Shouldn't new tweets appear on top?
    # Fixed: NG
    
		@tweets = Tweet.find_by_sql("select tweets.* from tweets where user_id = #{current_user.id} UNION select tweets.* from tweets_users INNER JOIN follows ON tweets_users.user_id = following_id INNER JOIN tweets ON tweets_users.tweet_id = tweets.id where follows.user_id = #{current_user.id} UNION select tweets.* from tweets INNER JOIN follows ON tweets.user_id = follows.following_id where follows.user_id = #{current_user.id} UNION select * from tweets where ttype = 'public'").sort.reverse
				
		respond_to do |format|
			format.html
		end
	end

	def create
    # FIXME: WA: Anyone can forge a form and tweet on behalf of
    # anyone. Use current_user.tweets.build
    #
    # Here you are first _create_ and then save the same record
    # back to database.
    
    #Fixed: NG
	  @tweet = current_user.tweets.build(params[:tweet])

		respond_to do |format|
		  if @tweet.save
		    format.html { redirect_to tweets_path, notice: 'Tweet was successfully posted.' }
		  else
		  	render :text => "Tweet was not saved successfully!"
		  end
		end
	end
	
	def destroy
		begin
			@tweet = current_user.tweets.find(params[:id])
		rescue ActiveRecord::RecordNotFound
			render :text => "Record Not Found"
		end
		
    # FIXME: WA: You are calling the same method twice in succession.
    # Please see create action how to do it properly.
    # Try not to use 'and' use && instead.
    # Fixed: NG

    # QUESTION: WA: When a tweet is destroyed, what happens to its
    # retweets? Do they remain in the database? Are other users still
    # able to see their messages?
    
    # Answer: NG: No, they'll not be able to see their retweets as dependent will be destroyed (managed through dependent => destroy).
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
