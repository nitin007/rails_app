class FollowshipsController < ApplicationController
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
      # FIXME: WA: What happens if followship was not created.
      # Fixed: NG
      if @followship.save
		    format.html { redirect_to whoToFollow_path, notice: 'Followship was successfully created.' } 
		  else
		  	render :text => "Followship was not created."
		  end
    end
  end

  def destroy
		begin
	    @followship = Followship.find(params[:id])
	  rescue ActiveRecord::RecordNotFound
	  	render :text => "Record Not Found"
	  end
    # FIXME: WA: What happens when a followship was not destroyed.
    # Fixed: NG
    
    @followship.destroy
    render :text => 'Followship not destroyed' and return if !@followship.destroy

    respond_to do |format|
      format.html { redirect_to whoToFollow_path }
    end
  end
end
