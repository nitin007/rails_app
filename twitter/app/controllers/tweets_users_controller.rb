class TweetsUsersController < ApplicationController
	def create
	  @tweet_user = TweetsUser.create(params[:tweets_user])

		respond_to do |format|
		  if @tweet_user.save
		    format.html { redirect_to tweets_path, notice: 'Tweet was successfully posted.' }
		  else
		  	format.html { render action: "index" }
		  end
		end
	end
	
	def destroy		
		@tweet_user = TweetsUser.find(params[:id])
		@tweet_user.destroy
		
		respond_to do |format|
			format.js
		end
	end
end
