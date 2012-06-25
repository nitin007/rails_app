class Tweet < ActiveRecord::Base
	include UsersHelper
  attr_accessible :message, :ttype, :user_id
  
  # TODO: WA: You are missing a belongs_to association to User model.
  # Fixed: NG
  has_many :tweets_users, :dependent => :destroy
  has_many :users, :through => :tweets_users
  belongs_to :user
  
  validates :message, :length => {:maximum => 160}
  # FIXME: WA: You do not have any validation on message length.
  # This will let users creae tweets more than specified number
  # of characters.
  # Fixed :NG I was also managing this with javascript. Do we really need to manage here?
  
 	def find_if_retweeted(uid)
		TweetsUser.find(:first, :conditions => ['user_id = ? and tweet_id = ?', uid, self.id])
	end
end
