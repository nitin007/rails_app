class User < ActiveRecord::Base
	#extend FriendlyId
	#friendly_id :username, :use => :slugged

  attr_accessible :email, :fullname, :password, :password_digest, :username, :password_confirmation, :slug
  
  validates :fullname, :presence => true
  validates :email, :presence => true
  validates :username, :presence => true, :uniqueness => true
  validates :password, :length => {:minimum => 8}
  
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
 
  # FIXME: WA: Use sensible names.
  # Fixed: NG
  has_many :follows
  has_many :followings, :through => :follows
  # TODO: WA: If you read this please come to me so that we can discuss
  # following.
  # Fixed: NG
  has_many :inverse_follows, :class_name => "Follow", :foreign_key => :following_id
  has_many :inverse_followings, :through => :inverse_follows, :source => :user
  
  has_many :tweets_users
  has_many :tweets, :through => :tweets_users
  has_many :tweets
  
  has_secure_password
    
  # OPTIMIZE: WA: It is much better to pass the whole user
  # object in following method than its id. This way,
  # you work with an existing object and do not have
  # to fire up unnecessary SQLs.
  #
  # TODO: WA: Write test for following.
  def followed?(uid)
  	User.find(uid).follows.find_by_following_id(self.id)
  end
  
  def to_param
  	username
  end
end
