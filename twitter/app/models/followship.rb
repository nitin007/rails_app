class Followship < ActiveRecord::Base
  attr_accessible :followerTo_id, :user_id
  
  belongs_to :user
  belongs_to :followerTo, :class_name => "User"
end
