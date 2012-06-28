class FollowsController < ApplicationController
	before_filter :only_when_user_is_logged_in
	
	def index
		@users = User.where('id != ?', current_user.id)
			
		respond_to do |format|
			format.html
		end		
	end

  def create
    @follows = current_user.follows.build(:following_id => params[:following_id])
    
    respond_to do |format|
      if @follows.save
		    format.html { redirect_to whoToFollow_path, notice: 'Follow was successfully created.' } 
		  else
		  	render :text => "Follow was not created."
		  end
    end
  end

  # TODO: WA: Test following action thoroughly.
  def destroy
		begin
	    @following = current_user.followings.find(params[:id])
	  rescue ActiveRecord::RecordNotFound
	  	render :text => "Record Not Found"
	  end
    render :text => 'Following not destroyed' && return if !@following.destroy

    respond_to do |format|
      format.html { redirect_to whoToFollow_path }
    end
  end
end
