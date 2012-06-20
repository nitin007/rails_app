class FollowshipsController < ApplicationController
	before_filter :only_when_user_is_logged_in
	
	def index
		@users = User.where('id != ?', current_user.id)
			
		respond_to do |format|
			format.html
		end		
	end

  def create
    @followship = current_user.followships.build(:followerTo_id => params[:followerTo_id])
    
    respond_to do |format|
	    format.html { redirect_to whoToFollow_path, notice: 'Followship was successfully created.' } if @followship.save
    end
  end

  def destroy
		begin
	    @followship = Followship.find(params[:id])
	  rescue ActiveRecord::RecordNotFound
	  	render :text => "Record Not Found"
	  end
    @followship.destroy

    respond_to do |format|
      format.html { redirect_to whoToFollow_path }
    end
  end
end
