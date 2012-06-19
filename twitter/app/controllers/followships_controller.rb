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
      if @followship.save
        format.html { redirect_to whoToFollow_path, notice: 'Followship was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def destroy
    @followship = Followship.find(params[:id])
    @followship.destroy

    respond_to do |format|
      format.html { redirect_to whoToFollow_path }
    end
  end
end
