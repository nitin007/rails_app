class ImagesController < ApplicationController
  # Fixed: NG
 	before_filter :only_when_user_is_logged_in, :fetch_image
  def show  
    # Refactored: NG
      
    respond_to do |format|
	    format.html
	  end
  end

  def destroy
    # Refactored: NG

	  @image.destroy		  
		redirect_to albums_path, :notice => "Image was not destroyed!" if !@image.destroyed?

    respond_to do |format|
      format.html { redirect_to albums_path }
    end
  end
end

def fetch_image
	begin
		@image ||= @current_user.albums.find(params[:album_id]).images.find(params[:id])
    #	FIXME: WA: Following will fetch any image for display, destruction.
    #	Not neccessarily current user's.
		#@image ||= Image.find(params[:id])
		#Fixed: NG
	rescue ActiveRecord::RecordNotFound
		redirect_to album_path(current_album) and return
	end
end

