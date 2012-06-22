class TweetsUsersController < ApplicationController
  # QUESTION: WA: Do we really need this controller?
  # ANSWER: we need this to manage retweets.
  
	def create
	  @tweet_user = current_user.tweets_users.create(params[:tweets_user])

		respond_to do |format|
		  if @tweet_user.save
		    format.html { redirect_to tweets_path, notice: 'Tweet was successfully posted.' }
		  else
		  	format.html { render :text => "tweet was not saved successfully" }
		  end
		end
	end
	
	def destroy		
		begin
			@tweet_user = current_user.tweets_users.find(params[:id])
		rescue ActiveRecord::RecordNotFound
			render :text => "Record Not Found"
		end
		@tweet_user.destroy
		
		respond_to do |format|
			format.html {redirect_to tweets_path}
		end
	end
end	
