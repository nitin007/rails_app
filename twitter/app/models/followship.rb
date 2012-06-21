class Followship < ActiveRecord::Base
  attr_accessible :following_id, :user_id
  
  belongs_to :user
  belongs_to :following, :class_name => "User"
end
