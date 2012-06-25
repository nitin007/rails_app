class FollowshipsController < ApplicationController
  # TODO: WA: Test this controller more thoroughly.
	before_filter :only_when_user_is_logged_in
	
	def index
		@users = User.where('id != ?', current_user.id)
			
		respond_to do |format|
			format.html
		end		
	end

  def create
    @followship = current_user.followships.build(:following_id => params[:following_id])
    
    respond_to do |format|
      if @followship.save
		    format.html { redirect_to whoToFollow_path, notice: 'Followship was successfully created.' } 
		  else
		  	render :text => "Followship was not created."
		  end
    end
  end

  def destroy
		begin
	    @followship = current_user.followships.find(params[:id])
	  rescue ActiveRecord::RecordNotFound
	  	render :text => "Record Not Found"
	  end
    # FIXME: WA: You are calling the same method twice in succession.
    # Please see create action how to do it properly.
    # Try not to use 'and' use && instead.
    @followship.destroy
    render :text => 'Followship not destroyed' and return if !@followship.destroy

    respond_to do |format|
      format.html { redirect_to whoToFollow_path }
    end
  end
end
