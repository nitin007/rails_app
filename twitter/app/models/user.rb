class User < ActiveRecord::Base
	extend FriendlyId
	friendly_id :username, :use => :slugged

  attr_accessible :email, :fullname, :password, :password_digest, :username, :password_confirmation
  
  validates :fullname, :presence => true
  validates :email, :presence => true
  validates :username, :presence => true, :uniqueness => true
  validates :password, :length => {:minimum => 8}
  
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
 
  has_many :followships
  has_many :followerTos, :through => :followships
  has_many :inverse_followships, :class_name => "Followship", :foreign_key => :followerTo_id
  has_many :inverse_followerTos, :through => :inverse_followships, :source => :user
  
  has_many :tweets_users
  has_many :tweets, :through => :tweets_users
  
  has_secure_password
end
