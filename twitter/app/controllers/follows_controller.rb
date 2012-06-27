class FollowsController < ApplicationController
  # TODO: WA: Test this controller more thoroughly.
  # Fixed: NG
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

  def destroy
		begin
	    @following = current_user.followings.find(params[:id])
	  rescue ActiveRecord::RecordNotFound
	  	render :text => "Record Not Found"
	  end
    # FIXME: WA: You are calling the same method twice in succession.
    # Please see create action how to do it properly.
    # Try not to use 'and' use && instead.
    #Fixed: NG
    render :text => 'Following not destroyed' && return if !@following.destroy

    respond_to do |format|
      format.html { redirect_to whoToFollow_path }
    end
  end
end
