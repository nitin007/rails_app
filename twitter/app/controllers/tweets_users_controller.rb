class TweetsUsersController < ApplicationController
  # TODO: WA: Test this controller more thoroughly.
  before_filter :only_when_user_is_logged_in
  
	def create
	  @tweet_user = current_user.tweets_users.new(params[:tweets_user])

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
			@retweet = current_user.tweets_users.find(params[:id])
		rescue ActiveRecord::RecordNotFound
			render :text => "Record Not Found"
		end
		
		render :text => "Retweet not posted successfully" && return if !@retweet.destroy
		
		respond_to do |format|
			format.html {redirect_to tweets_path}
		end
	end
end	
